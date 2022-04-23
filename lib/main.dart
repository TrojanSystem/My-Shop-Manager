import 'package:example/model/daily_sell_data.dart';
import 'package:example/model/expenses_data.dart';
import 'package:example/model/shop_model_data.dart';
import 'package:example/screen/home_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/functionality_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ShopModelData()..loadShopList(),
        ),
        ChangeNotifierProvider(
          create: (context) => ExpensesData()..loadExpenseList(),
        ),
        ChangeNotifierProvider(
          create: (context) => DailySellData()..loadDailySellList(),
        ),
        ChangeNotifierProvider(
          create: (context) => FunctionalityData(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Store Manager',
        home: HomePage(),
      ),
    );
  }
}
