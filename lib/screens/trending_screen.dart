import 'package:flutter/material.dart';
import 'package:flutter_coin_project/components/trending_coin_list.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({Key? key}) : super(key: key);

  @override
  _TrendingScreenState createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TrendingCoinList(),
    );
  }
}
