import 'package:example/input_form/add_expense.dart';
import 'package:example/model/expenses_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../item/add_button_item.dart';
import '../item/daily_expense_item.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 38.0, right: 30),
                child: AddButton(
                  navigateToPage: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const AddExpense(),
                      ),
                    );
                  },
                  colour: Colors.red,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Daily Expense: 300.50',
                    style: dailyIncomeStyle,
                  ),
                ),
                color: const Color.fromRGBO(3, 83, 151, 1),
              ),
            ),
            Expanded(
              flex: 12,
              child: dailyExpense.expenseList.isEmpty
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
                      : ExpenseItem(dailyExpense: dailyExpense.expenseList),
            ),
          ],
        ),
      ),
    );
  }
}
