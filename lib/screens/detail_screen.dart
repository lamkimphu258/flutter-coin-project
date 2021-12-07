import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coin_project/components/widget_statistics.dart';
import 'package:flutter_coin_project/models/coin.dart';
import 'package:flutter_coin_project/utils/NumberUtils.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatelessWidget {
  final Coin coin;

  const DetailScreen({Key? key, required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [_buildAppBar(context), Expanded(child: _buildBody(context))],
      ),
    ));
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("${coin.symbol} Statistics",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.bold)),
            WidgetStatistics(
                widgetStart: const Text("Price"), widgetEnd: Container()),
            WidgetStatistics(
                widgetStart: const Text("Current Price"),
                widgetEnd: Row(
                  children: [
                    _buildPrice(coin.currentPrice),
                    _buildPriceChange(coin.priceChangePercentage24h)
                  ],
                )),
            WidgetStatistics(
                widgetStart: const Text("Price Change 24h"),
                widgetEnd: _buildPrice(coin.priceChange24h)),

            // detail
            WidgetStatistics(
                widgetStart: const Text("Details"), widgetEnd: Container()),
            WidgetStatistics(
                widgetStart: const Text("Market Cap"),
                widgetEnd: Row(
                  children: [
                    _buildPrice(coin.marketCap),
                    _buildPriceChange(coin.marketCapChangePercentage24h)
                  ],
                )),

            WidgetStatistics(
                widgetStart: const Text("Fully Diluted Market "),
                widgetEnd: Row(
                  children: [
                    _buildPrice(coin.fullyDilutedValuation),
                    _buildPriceChange(coin.marketCapChangePercentage24h)
                  ],
                )),

            WidgetStatistics(
                widgetStart: const Text("Circulating Supply"),
                widgetEnd: Row(
                  children: [
                    Text(NumberUtils.convertNumberToHumanReadable(
                        coin.circulatingSupply)),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Colors.amber,
                ),
                value:
                    coin.circulatingSupply != null && coin.totalSupply != null
                        ? coin.circulatingSupply / coin.totalSupply
                        : 0,
              ),
            ),
            WidgetStatistics(
              widgetStart: const Text("Max Supply"),
              widgetEnd: Row(
                children: [
                  Text(
                      "${coin.maxSupply != null ? NumberUtils.convertNumberToHumanReadable(coin.maxSupply) : 0}"),
                ],
              ),
              isShowLine: false,
            ),
            WidgetStatistics(
                widgetStart: const Text("Total Supply"),
                widgetEnd: Row(
                  children: [
                    Text(
                        "${coin.totalSupply != null ? NumberUtils.convertNumberToHumanReadable(coin.totalSupply) : 0}"),
                  ],
                )),

            WidgetStatistics(
                widgetStart: const Text("Rank"),
                widgetEnd: Row(
                  children: [
                    Text("#${coin.marketCapRank}"),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_sharp)),
          const SizedBox(
            width: 8,
          ),
          Image.network(
            coin.image,
            width: 25,
            height: 25,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(coin.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Widget _buildPrice(dynamic price) {
  //   return Text(NumberFormat.currency(locale: 'en').format(price));
  // }

  Widget _buildPrice(dynamic price) {
    return Text("US\$" + NumberUtils.convertNumberToHumanReadable(price ?? 0));
  }

  Widget _buildPriceChange(dynamic priceChange) {
    bool isUp = priceChange > 0;
    return Row(
      children: [
        Icon(
          isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          color: isUp ? Colors.green : Colors.red,
        ),
        Text(
          "$priceChange%",
          style: TextStyle(color: isUp ? Colors.green : Colors.red),
        )
      ],
    );
  }
}
