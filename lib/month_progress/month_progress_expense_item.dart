import 'package:example/model/expenses_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'month_progress_expense_detail_item.dart';

class MonthProgressItem extends StatefulWidget {
  MonthProgressItem({Key key}) : super(key: key);

  @override
  State<MonthProgressItem> createState() => _MonthProgressItemState();
}

class _MonthProgressItemState extends State<MonthProgressItem> {
  int selectedMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    final monthSelected = Provider.of<ExpensesData>(context).monthOfAYear;

    final yearFilter = Provider.of<ExpensesData>(context).expenseList;
    final monthFilterList = yearFilter
        .where((element) =>
            DateTime.parse(element.itemDate).year == DateTime.now().year)
        .toList();
    var todayFilteredExpenseList = monthFilterList
        .where((element) =>
            DateTime.parse(element.itemDate).month == selectedMonth)
        .toList();

    var filterName =
        todayFilteredExpenseList.map((e) => e.itemName).toSet().toList();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(3, 83, 151, 1),
          ),
        ),
        title: const Text('Monthly Expense'),
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
      body: ListView.builder(
        itemCount: filterName.length,
        itemBuilder: (context, index) {
          return MonthProgressDetailItem(
            todayFilteredList: todayFilteredExpenseList,
            index: index,
          );
        },
      ),
    );
  }
}
