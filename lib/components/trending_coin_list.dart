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
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            snapshot.data![index].name,
                            style: Theme.of(context).textTheme.headline6,
                          ))
                    ]);
              });
          //   return Text(snapshot.data!.name);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
