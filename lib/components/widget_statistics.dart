import 'package:flutter/material.dart';

class WidgetStatistics extends StatelessWidget {
  final Widget widgetStart;
  final Widget widgetEnd;
  final bool isShowLine;

  const WidgetStatistics(
      {Key? key,
      required this.widgetStart,
      required this.widgetEnd,
      this.isShowLine = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 60,
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [widgetStart, const Spacer(), widgetEnd],
            ),
          ),
          Visibility(
            visible: isShowLine ? true : false,
            child: const Divider(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
