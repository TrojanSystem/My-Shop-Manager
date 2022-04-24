import 'package:example/model/functionality_data.dart';
import 'package:example/storage/storage_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../expense_data/expense_screen.dart';
import '../item/bottom_nav_item.dart';
import '../sold_items_data/daily_sell_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  final List homePageScreen = [
    const StorageScreen(),
    DailySellScreen(),
    ExpenseScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final index = Provider.of<FunctionalityData>(context).currentIndex;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
      body: homePageScreen[index],
      bottomNavigationBar: const MyCustomBottomNavigationBar(),
    );
  }
}
