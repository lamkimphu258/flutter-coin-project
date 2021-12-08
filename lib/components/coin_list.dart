import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_coin_project/models/coin.dart';
import 'package:flutter_coin_project/models/recent_coin.dart';
import 'package:flutter_coin_project/screens/detail_screen.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CoinList extends StatefulWidget {
  const CoinList({Key? key}) : super(key: key);

  @override
  _CoinListState createState() => _CoinListState();
}

class _CoinListState extends State<CoinList> {
  late Future<List<Coin>> futureCoin;

  Future<List<Coin>> fetchCoin() async {
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=1000&page=1&sparkline=false'));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List<Coin> myList = [];
      for (var i = 0; i < jsonResponse.length; i++) {
        myList.add(Coin.fromJson(jsonResponse[i]));
      }
      return myList;
    } else {
      throw Exception('Failed to load trending coin');
    }
  }

  @override
  void initState() {
    super.initState();
    futureCoin = fetchCoin();
  }

  Future<Database> initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), 'coin_tracker.db'),
    );
    return database;
  }

  Future<void> insertRecentCoin(database, RecentCoin recentCoin) async {
    final db = await database;
    await db.insert(
      'recent_coin',
      recentCoin.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Coin>>(
      future: futureCoin,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          child: Text(
                            'Coin',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          width: 50),
                      const SizedBox(width: 170),
                      SizedBox(
                        child: Text(
                          'Price',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        width: 100,
                      ),
                    ]),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {
                                    var database = initDatabase();
                                    var recentCoin = RecentCoin(
                                        image: snapshot.data![index].image,
                                        name: snapshot.data![index].name,
                                        visitedAt: DateTime.parse(DateTime.now().toString()));
                                    insertRecentCoin(database, recentCoin);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                coin: snapshot.data![index])));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        snapshot.data![index].image,
                                        scale: 5.0,
                                      ),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        child: Text(
                                          snapshot.data![index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                          textAlign: TextAlign.start,
                                        ),
                                        width: 150,
                                      ),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        child: Text(
                                            NumberFormat.currency(locale: 'en')
                                                .format(snapshot
                                                    .data![index].currentPrice),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2),
                                        width: 100,
                                      ),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                ))
                          ]);
                    }),
              ),
            ],
          );
          //   return Text(snapshot.data!.name);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
