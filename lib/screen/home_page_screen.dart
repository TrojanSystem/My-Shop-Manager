import 'package:example/model/functionality_data.dart';
import 'package:example/screen/storage_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../item/bottom_nav_item.dart';
import 'daily_sell_screen.dart';
import 'expense_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  final List homePageScreen = [
    const StorageScreen(),
    const DailySellScreen(),
    const ExpenseScreen(),
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
