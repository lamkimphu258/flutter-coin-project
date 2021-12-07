import 'package:flutter/material.dart';
import 'package:flutter_coin_project/components/recent_list.dart';

class RecentScreen extends StatefulWidget {
  const RecentScreen({Key? key}) : super(key: key);

  @override
  _RecentScreenState createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RecentList(),
    );
  }
}
