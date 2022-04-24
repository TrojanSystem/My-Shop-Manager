import 'package:example/model/shop_model.dart';
import 'package:example/sold_items_data/daily_sell_data.dart';
import 'package:example/sold_items_data/update_daily_sell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DailySellItem extends StatelessWidget {
  final List soldItem;
  final int selectedDay;

  const DailySellItem({this.selectedDay, this.soldItem});

  // final int index;

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return AnimationLimiter(
      child: ListView.builder(
        padding: EdgeInsets.all(_w / 23),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: soldItem.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            delay: const Duration(milliseconds: 100),
            child: SlideAnimation(
              duration: const Duration(milliseconds: 2500),
              curve: Curves.fastLinearToSlowEaseIn,
              horizontalOffset: -300,
              verticalOffset: -850,
              child: Container(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  DateTime.parse(soldItem[index].itemDate),
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
                          margin: const EdgeInsets.only(left: 20, top: 10),
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
                                    soldItem[index].itemName,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'x ${soldItem[index].itemQuantity}',
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
                                          builder: (_) => UpdateDailySell(
                                            index: soldItem[index].id,
                                            existedItemName:
                                                soldItem[index].itemName,
                                            existedItemDate:
                                                soldItem[index].itemDate,
                                            existedItemPrice:
                                                soldItem[index].itemPrice,
                                            existedItemQuantity:
                                                soldItem[index].itemQuantity,
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
                                      Provider.of<DailySellData>(context,
                                              listen: false)
                                          .deleteDailySellList(
                                              soldItem[index].id);
                                      double totalMinus =
                                          Provider.of<DailySellData>(context,
                                                  listen: false)
                                              .minusTotalPrice(double.parse(
                                                  soldItem[index].itemPrice));
                                      final updateExpense = ShopModel(
                                        id: soldItem[index].id,
                                        itemName: soldItem[index].itemName,
                                        itemDate: soldItem[index].itemDate,
                                        itemPrice: soldItem[index].itemPrice,
                                        itemQuantity:
                                            soldItem[index].itemQuantity,
                                        total: totalMinus.toString(),
                                      );
                                      Provider.of<DailySellData>(context,
                                              listen: false)
                                          .updateShopListDailySellList(
                                              updateExpense);
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
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 120,
                        height: 30,
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
                              soldItem[index].itemPrice,
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
          );
        },
      ),
    );
  }
}
