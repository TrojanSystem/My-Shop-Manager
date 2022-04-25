import 'package:example/sold_items_data/daily_sell_data.dart';
import 'package:example/storage/shop_model_data.dart';
import 'package:example/storage/storage_pdf_report.dart';
import 'package:example/storage/update_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../model/shop_model.dart';

class ItemDetails extends StatelessWidget {
  final List storageList;
  final int length;
  final String witchButtonPressed;

  ItemDetails({this.storageList, this.length, this.witchButtonPressed});

  // final int index;

  @override
  Widget build(BuildContext context) {
    final adjusted = Provider.of<DailySellData>(context).currentQuantity;
    double _w = MediaQuery.of(context).size.width;

    final List<StoragePDFReport> newLabour = [];
    return AnimationLimiter(
      child: ListView.builder(
        padding: EdgeInsets.all(_w / 30),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            delay: const Duration(milliseconds: 100),
            child: SlideAnimation(
              duration: const Duration(milliseconds: 2500),
              curve: Curves.fastLinearToSlowEaseIn,
              horizontalOffset: -300,
              verticalOffset: -850,
              child: Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    IconButton(
                      color: Colors.red,
                      onPressed: () {
                        Provider.of<ShopModelData>(context, listen: false)
                            .deleteShopList(storageList[index].id);
                        double totalMinus =
                            Provider.of<ShopModelData>(context, listen: false)
                                .minusTotalPrice(
                                    double.parse(storageList[index].itemPrice));
                        final updateExpense = ShopModel(
                          id: storageList[index].id,
                          itemName: storageList[index].itemName,
                          itemDate: storageList[index].itemDate,
                          itemPrice: storageList[index].itemPrice,
                          itemQuantity: storageList[index].itemQuantity,
                          total: totalMinus.toString(),
                        );
                        Provider.of<ShopModelData>(context, listen: false)
                            .updateShopList(updateExpense);
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      color: Colors.green,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => UpdateStorage(
                              index: storageList[index].id,
                              existedItemName: storageList[index].itemName,
                              existedItemDate: storageList[index].itemDate,
                              existedItemPrice: storageList[index].itemPrice,
                              existedItemQuantity:
                                  storageList[index].itemQuantity,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                storageList[index].itemPrice,
                                style: storageItemMoney,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'ETB',
                                style: storageItemCurrency,
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                witchButtonPressed == 'sold'
                                    ? storageList[index].itemName
                                    : storageList[index].itemQuantity,
                                style: storageItemName,
                              ),
                            ),
                            subtitle: Text(
                              DateFormat.yMMMEd().format(
                                DateTime.parse(storageList[index].itemDate),
                              ),
                              style: storageItemDate,
                            ),
                            trailing: Text(
                              witchButtonPressed == 'sold'
                                  ? "x ${storageList[index].itemQuantity}"
                                  : '',
                              style: TextStyle(
                                color: Colors.green[800],
                                fontFamily: 'FjallaOne',
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
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
