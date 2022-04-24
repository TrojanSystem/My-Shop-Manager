import 'package:example/expense_data/expenses_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../sold_items_data/daily_sell_data.dart';
import 'item_details.dart';

class ItemScreen extends StatefulWidget {
  ItemScreen({this.witchButtonPressed});

  String witchButtonPressed;

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  int selectedMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    final monthSelected = Provider.of<DailySellData>(context).monthOfAYear;
    final soldItemDetail = Provider.of<DailySellData>(context).dailySellList;
    final expenseItemDetail = Provider.of<ExpensesData>(context).expenseList;
    final filterSoldByYear = soldItemDetail
        .where((element) =>
            DateTime.parse(element.itemDate).year == DateTime.now().year)
        .toList();
    final filterSoldByMonth = filterSoldByYear
        .where((element) =>
            DateTime.parse(element.itemDate).month == selectedMonth)
        .toList();

    final filterExpenseByYear = expenseItemDetail
        .where((element) =>
            DateTime.parse(element.itemDate).year == DateTime.now().year)
        .toList();
    final filterExpenseByMonth = filterExpenseByYear
        .where((element) =>
            DateTime.parse(element.itemDate).month == selectedMonth)
        .toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(3, 83, 151, 1),
          ),
        ),
        title: const Text('Items Detail'),
        actions: [
          DropdownButton(
            dropdownColor: Colors.grey[850],
            iconEnabledColor: Colors.white,
            menuMaxHeight: 300,
            value: selectedMonth,
            items: monthSelected
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
                selectedMonth = value;
              });
            },
          ),
        ],
      ),
      body: widget.witchButtonPressed == 'sold'
          ? ItemDetails(
              storageList: filterSoldByMonth,
              length: filterSoldByMonth.length,
              witchButtonPressed: widget.witchButtonPressed)
          : ItemDetails(
              storageList: filterExpenseByMonth,
              length: filterExpenseByMonth.length,
              witchButtonPressed: widget.witchButtonPressed),
    );
  }
}
