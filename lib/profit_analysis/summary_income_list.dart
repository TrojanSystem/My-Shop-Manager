import 'package:example/input_form/update_daily_sell.dart';
import 'package:example/model/daily_sell_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SummaryIncomeList extends StatelessWidget {
  // final int index;
  final String month;
  final int selectedCurrentYear;

  SummaryIncomeList({this.month, this.selectedCurrentYear});

  @override
  Widget build(BuildContext context) {
    final accessor = Provider.of<DailySellData>(context);
    final summaryDataList = Provider.of<DailySellData>(context).dailySellList;
    final filtereByYear = summaryDataList
        .where((element) =>
            DateTime.parse(element.itemDate).year == selectedCurrentYear)
        .toList();

    var monthExpense = filtereByYear
        .where((element) =>
            DateFormat.MMM()
                .format(DateTime.parse(element.itemDate))
                .toString() ==
            month.toString())
        .toList();
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(3, 83, 151, 1).withOpacity(0.9),
          title: const Text('Income Detail'),
          centerTitle: true,
          brightness: Brightness.dark),
      body: AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.all(_w / 30),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: monthExpense.length,
          itemBuilder: (BuildContext context, int index) {
            monthExpense.sort((a, b) => b.itemDate.compareTo(a.itemDate));
            return AnimationConfiguration.staggeredList(
              position: index,
              delay: const Duration(milliseconds: 100),
              child: SlideAnimation(
                duration: const Duration(milliseconds: 2500),
                curve: Curves.fastLinearToSlowEaseIn,
                horizontalOffset: -300,
                verticalOffset: -850,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (ctx) => UpdateDailySell(
                        index: monthExpense[index].id,
                        existedItemName: monthExpense[index].itemName,
                        existedItemDate: monthExpense[index].itemDate,
                        existedItemPrice: monthExpense[index].itemPrice,
                        existedItemQuantity: monthExpense[index].itemQuantity,
                      ),
                    );
                  },
                  onLongPress: () {
                    accessor.deleteDailySellList(monthExpense[index].id);
                  },
                  child: Container(
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 8.0, 15, 0),
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
                                      DateTime.parse(
                                          monthExpense[index].itemDate),
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
                              margin: const EdgeInsets.only(left: 15, top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    monthExpense[index].itemName,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'x ${monthExpense[index].itemQuantity}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 120,
                            height: 25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  Icons.arrow_downward_rounded,
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
                                  monthExpense[index].itemPrice.toString(),
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
      ),
    );
  }
}
