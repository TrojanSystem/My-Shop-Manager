import 'package:flutter/material.dart';

import '../profit_analysis/profit_analysis_screen.dart';
import 'daily_sell_drop_down_list_item.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: const Color.fromRGBO(3, 83, 151, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DailySellDropDownListItem(
                    title: 'Daily Sell',
                    listItem1: 'Item Progress',
                    listItem2: 'Sold Items',
                  ),
                  const DailySellDropDownListItem(
                    title: 'Expense Tracker',
                    listItem1: 'Monthly Progress',
                    listItem2: 'Expense Detail',
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
