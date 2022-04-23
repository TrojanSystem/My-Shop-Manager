import 'package:example/model/expenses_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../input_form/update_expense.dart';
import '../model/shop_model.dart';

class ExpenseItem extends StatelessWidget {
  final List dailyExpense;
  ExpenseItem({this.dailyExpense});

  // final int index;

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return AnimationLimiter(
      child: ListView.builder(
        padding: EdgeInsets.all(_w / 30),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: dailyExpense.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            delay: const Duration(milliseconds: 100),
            child: SlideAnimation(
              duration: const Duration(milliseconds: 2500),
              curve: Curves.fastLinearToSlowEaseIn,
              horizontalOffset: -300,
              verticalOffset: -850,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 15, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  DateFormat.yMMMEd().format(
                                    DateTime.now(),
                                  ),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20, top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      dailyExpense[index].itemName,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${dailyExpense[index].itemQuantity}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => UpdateExpense(
                                              index: dailyExpense[index].id,
                                              existedItemName:
                                                  dailyExpense[index].itemName,
                                              existedItemDate:
                                                  dailyExpense[index].itemDate,
                                              existedItemPrice:
                                                  dailyExpense[index].itemPrice,
                                              existedItemQuantity:
                                                  dailyExpense[index]
                                                      .itemQuantity,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                        size: 25,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        Provider.of<ExpensesData>(context,
                                                listen: false)
                                            .deleteExpenseList(
                                                dailyExpense[index].id);
                                        double totalMinus = Provider.of<
                                                    ExpensesData>(context,
                                                listen: false)
                                            .minusTotalPrice(double.parse(
                                                dailyExpense[index].itemPrice));
                                        final updateExpense = ShopModel(
                                          id: dailyExpense[index].id,
                                          itemName:
                                              dailyExpense[index].itemName,
                                          itemDate:
                                              dailyExpense[index].itemDate,
                                          itemPrice:
                                              dailyExpense[index].itemPrice,
                                          itemQuantity:
                                              dailyExpense[index].itemQuantity,
                                          total: totalMinus.toString(),
                                        );
                                        Provider.of<ExpensesData>(context,
                                                listen: false)
                                            .updateExpenseList(updateExpense);
                                      },
                                      icon: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                        size: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        left: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 120,
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(
                                Icons.arrow_upward_rounded,
                                size: 20,
                                color: Colors.white,
                              ),
                              const Text(
                                'ETB ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                dailyExpense[index].itemPrice,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(bottom: _w / 20),
                  height: _w / 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
