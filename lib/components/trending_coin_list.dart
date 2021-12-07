import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_coin_project/models/trending_coin.dart';
import 'package:http/http.dart' as http;

class TrendingCoinList extends StatefulWidget {
  const TrendingCoinList({Key? key}) : super(key: key);

  @override
  _TrendingCoinListState createState() => _TrendingCoinListState();
}

class _TrendingCoinListState extends State<TrendingCoinList> {
  late Future<List<TrendingCoin>> futureTrendingCoin;

  Future<List<TrendingCoin>> fetchTrendingCoin() async {
    final response = await http
        .get(Uri.parse('https://api.coingecko.com/api/v3/search/trending'));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body)['coins'];
      List<TrendingCoin> myList = [];
      for (var i = 0; i < jsonResponse.length; i++) {
        myList.add(TrendingCoin.fromJson(jsonResponse[i]['item']));
      }
      return myList;
    } else {
      throw Exception('Failed to load trending coin');
    }
  }

  @override
  void initState() {
    super.initState();
    futureTrendingCoin = fetchTrendingCoin();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<List<TrendingCoin>>(
      future: futureTrendingCoin,
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
                      const SizedBox(width: 200),
                      SizedBox(
                        child: Text(
                          'Rank',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        width: 70,
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    child: Image.network(
                                      snapshot.data![index].thumb,
                                    ),
                                    width: 50,
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    child: Text(
                                      snapshot.data![index].name,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                      textAlign: TextAlign.start,
                                    ),
                                    width: 170,
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    child: Text(
                                      snapshot.data![index].marketCapRank
                                          .toString(),
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                      textAlign: TextAlign.start,
                                    ),
                                    width: 50,
                                  ),
                                ],
                              ),
                            )
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
