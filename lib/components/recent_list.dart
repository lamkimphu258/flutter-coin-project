import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_coin_project/models/coin.dart';
import 'package:flutter_coin_project/screens/detail_screen.dart';
import 'package:http/http.dart' as http;

class RecentList extends StatefulWidget {
  const RecentList({Key? key}) : super(key: key);

  @override
  _RecentListState createState() => _RecentListState();
}

class _RecentListState extends State<RecentList> {
  late Future<List<Coin>> futureCoin;

  Future<List<Coin>> fetchCoin() async {
    final response = await http.get(Uri.parse(
        ''));

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Coin>>(
      future: futureCoin,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                    coin: snapshot.data![index])));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            snapshot.data![index].image,
                            scale: 5.0,
                          ),
                          SizedBox(
                            child: Text(
                              snapshot.data![index].name,
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.start,
                            ),
                            width: 150,
                          ),
                          SizedBox(
                            child: Text(
                                "2h",
                                style:
                                Theme.of(context).textTheme.bodyText2),
                            width: 100,
                          ),
                        ],
                      ),
                    ));
              });
          //   return Text(snapshot.data!.name);
        } else if (snapshot.hasError) {
          return Text(('You haven\'t seen any coins').toUpperCase(), style: TextStyle(fontSize: 25));
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
