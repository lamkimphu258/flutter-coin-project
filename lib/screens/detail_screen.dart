import 'package:flutter/cupertino.dart';
import 'package:flutter_coin_project/models/coin.dart';

class DetailScreen extends StatelessWidget {
  final Coin coin;

  const DetailScreen({Key? key, required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(this.coin.name);
  }
}