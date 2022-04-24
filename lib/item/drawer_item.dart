import 'package:example/item/item_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../expense_data/expenses_data.dart';
import '../expense_data/month_progress_expense_item.dart';
import '../profit_analysis/profit_analysis_screen.dart';
import '../sold_items_data/daily_sell_data.dart';
import '../sold_items_data/month_progress_sold_item.dart';
import 'daily_sell_drop_down_list_item.dart';

class DrawerItem extends StatelessWidget {
  DrawerItem({Key key}) : super(key: key);
  int currentYear = DateTime.now().year;
  double totalSumation = 0.00;
  bool isNegative = false;
  @override
  Widget build(BuildContext context) {
    final summaryDataExpense = Provider.of<ExpensesData>(context).expenseList;
    final summaryDataSold = Provider.of<DailySellData>(context).dailySellList;

    final filtereByYearExpense = summaryDataExpense
        .where(
            (element) => DateTime.parse(element.itemDate).year == currentYear)
        .toList();
    final filtereByYearSold = summaryDataSold
        .where(
            (element) => DateTime.parse(element.itemDate).year == currentYear)
        .toList();

    var incomeFiltereByMonth = filtereByYearSold
        .map((e) => DateTime.parse(e.itemDate).month)
        .toSet()
        .toList();

    var totalIncome = filtereByYearSold.map((e) => e.itemPrice).toList();
    var totIncomeSum = 0.0;
    for (int xx = 0; xx < totalIncome.length; xx++) {
      totIncomeSum += double.parse(totalIncome[xx]);
    }

    var totalExpenses = filtereByYearExpense.map((e) => e.itemPrice).toList();
    var totExpenseSum = 0.0;
    for (int xx = 0; xx < totalExpenses.length; xx++) {
      totExpenseSum += double.parse(totalExpenses[xx]);
    }
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: const Center(
                child: Text(
                  'Shop Manager',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(3, 83, 151, 1),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: const Color.fromRGBO(3, 83, 151, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DailySellDropDownListItem(
                    title: 'Daily Sell',
                    listItem1: 'Item Progress',
                    listItem2: 'Sold Items',
                    buttonPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => MonthProgressSoldItem(),
                        ),
                      );
                    },
                    buttonPressedDetail: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ItemScreen(
                            witchButtonPressed: 'sold',
                          ),
                        ),
                      );
                    },
                  ),
                  DailySellDropDownListItem(
                    title: 'Expense Tracker',
                    listItem1: 'Monthly Progress',
                    listItem2: 'Expense Detail',
                    buttonPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => MonthProgressItem(),
                        ),
                      );
                    },
                    buttonPressedDetail: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ItemScreen(
                            witchButtonPressed: 'expense',
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22.0, 28, 8, 0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const ProfitAnalaysisScreen(),
                        ));
                      },
                      child: const Text(
                        'Profit Analysis',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
