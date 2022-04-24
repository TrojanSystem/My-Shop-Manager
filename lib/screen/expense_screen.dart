import 'package:example/input_form/add_expense.dart';
import 'package:example/model/expenses_data.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../item/daily_expense_item.dart';
import '../item/drop_down_menu_button.dart';
import '../month_progress/month_progress_expense_item.dart';
import '../profit_analysis/profit_analysis_screen.dart';

class ExpenseScreen extends StatefulWidget {
  ExpenseScreen({Key key}) : super(key: key);

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  int selectedDayOfMonth = DateTime.now().day;
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final yearFilter = Provider.of<ExpensesData>(context).expenseList;
    final result = yearFilter
        .where((element) =>
            DateTime.parse(element.itemDate).year == DateTime.now().year)
        .toList();

    var todayMonthFilteredList = result
        .where((element) =>
            DateTime.parse(element.itemDate).month == DateTime.now().month)
        .toList();
    var dailyExpenses = todayMonthFilteredList
        .where((element) =>
            DateTime.parse(element.itemDate).day == selectedDayOfMonth)
        .toList();
    var totSell = result
        .where((element) =>
            DateTime.parse(element.itemDate).month == DateTime.now().month)
        .toList();
    var totalSells = totSell.map((e) => e.itemPrice).toList();
    var totSum = 0.0;
    for (int xx = 0; xx < totalSells.length; xx++) {
      totSum += double.parse(totalSells[xx]);
    }
    var totalDailySells = dailyExpenses.map((e) => e.itemPrice).toList();
    var totDailySum = 0.0;
    for (int xx = 0; xx < totalDailySells.length; xx++) {
      totDailySum += double.parse(totalDailySells[xx]);
    }
    return Consumer<ExpensesData>(
      builder: (context, dailyExpense, child) => Scaffold(
          backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
            title: const Text(
              'Expenses',
              style: storageTitle,
            ),
            elevation: 0,
            toolbarHeight: 90,
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
                            items: dailyExpense.daysOfMonth
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
                child: dailyExpenses.isEmpty
                    ? const Center(
                        child: Text(
                          'Not yet!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      )
                    : dailyExpense.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.red,
                            ),
                          )
                        : ExpenseItem(dailyExpense: dailyExpenses),
              ),
            ],
          ),
          floatingActionButton: Builder(
            builder: (context) => DropDownMenuButton(
              button_1: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const AddExpense(),
                  ),
                );
              },
              button_2: () {
                print('Pdf');
              },
              button_3: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MonthProgressItem(),
                  ),
                );
              },
              button_4: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ProfitAnalaysisScreen(),
                  ),
                );
              },
            ),
          )),
    );
  }
}
