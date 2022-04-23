import 'package:example/input_form/add_daily_sell.dart';
import 'package:example/model/daily_sell_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../item/add_button_item.dart';
import '../item/daily_sell_item.dart';

class DailySellScreen extends StatefulWidget {
  DailySellScreen({Key key}) : super(key: key);

  @override
  State<DailySellScreen> createState() => _DailySellScreenState();
}

class _DailySellScreenState extends State<DailySellScreen> {
  int selectedDayOfMonth = DateTime.now().day;

  @override
  Widget build(BuildContext context) {
    final yearFilter = Provider.of<DailySellData>(context).dailySellList;
    final result = yearFilter
        .where((element) =>
            DateTime.parse(element.itemDate).year == DateTime.now().year)
        .toList();

    var todayMonthFilteredList = result
        .where((element) =>
            DateTime.parse(element.itemDate).month == DateTime.now().month)
        .toList();
    var dailySells = todayMonthFilteredList
        .where((element) =>
            DateTime.parse(element.itemDate).day == selectedDayOfMonth)
        .toList();

    var totSell = result
        .where((element) =>
            DateTime.parse(element.itemDate).month == DateTime.now().month)
        .toList();
    var totalQuantitySells = totSell.map((e) => e.itemQuantity).toList();

    var totalSells = totSell.map((e) => e.itemPrice).toList();
    var totSum = 0.0;
    for (int xx = 0; xx < totalSells.length; xx++) {
      totSum +=
          (double.parse(totalSells[xx]) * double.parse(totalQuantitySells[xx]));
    }
    var totalQuantityDailySells =
        dailySells.map((e) => e.itemQuantity).toList();

    var totalDailySells = dailySells.map((e) => e.itemPrice).toList();
    var totDailySum = 0.0;
    for (int xx = 0; xx < totalDailySells.length; xx++) {
      totDailySum += (double.parse(totalDailySells[xx]) *
          double.parse(totalQuantityDailySells[xx]));
    }
    return Consumer<DailySellData>(
      builder: (context, dailySell, child) => Scaffold(
        backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              // setState(() {
              //   Provider.of<FileHandler>(context, listen: false).createTable();
              // });
            },
            icon: const Icon(Icons.save),
          ),
          backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
          title: const Text(
            'Daily Sell',
            style: storageTitle,
          ),
          elevation: 0,
          toolbarHeight: 90,
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 38.0, right: 30),
                child: AddButton(
                  navigateToPage: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const AddStorageItem(),
                      ),
                    );
                  },
                  colour: Colors.green,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          dropdownColor: Colors.grey[850],
                          iconEnabledColor: Colors.white,
                          menuMaxHeight: 300,
                          value: selectedDayOfMonth,
                          items: dailySell.daysOfMonth
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Text(
                                    e['mon'],
                                    style: kkDropDown,
                                  ),
                                  value: e['day'],
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDayOfMonth = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Daily Income: $totDailySum',
                              style: dailyIncomeStyle,
                            ),
                            Text(
                              'Total: $totSum',
                              style: dailyIncomeStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                color: const Color.fromRGBO(3, 83, 151, 1),
              ),
            ),
            Expanded(
              flex: 12,
              child: dailySells.isEmpty
                  ? const Center(
                      child: Text(
                        'Not sold yet!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  : dailySell.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        )
                      : DailySellItem(
                          soldItem: dailySells,
                          selectedDay: selectedDayOfMonth),
            ),
          ],
        ),
      ),
    );
  }
}
