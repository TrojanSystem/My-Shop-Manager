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

class StorageListItem extends StatelessWidget {
  final List storageList;
  final List soldItemList;

  StorageListItem({this.storageList, this.soldItemList});

  // final int index;

  @override
  Widget build(BuildContext context) {
    final adjusted = Provider.of<DailySellData>(context).currentQuantity;
    double _w = MediaQuery.of(context).size.width;
    var FilterName = storageList.map((e) => e.itemName).toSet().toList();
    var FilterNameForSell =
        soldItemList.map((e) => e.itemName).toSet().toList();
    final List<StoragePDFReport> newLabour = [];
    return AnimationLimiter(
      child: ListView.builder(
        padding: EdgeInsets.all(_w / 30),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: FilterName.length,
        itemBuilder: (BuildContext context, int index) {
          var filteredNameForSell = soldItemList
              .where((element) => element.itemName == FilterName[index])
              .toSet();
          var filterPriceForSell =
              filteredNameForSell.map((e) => e.itemPrice).toList();
          var sumPriceForSell = 0.0;
          for (int x = 0; x < filteredNameForSell.length; x++) {
            sumPriceForSell += double.parse(filterPriceForSell[x]);
          }
          var filterQuantityForSell =
              filteredNameForSell.map((e) => e.itemQuantity).toList();
          var sumQuantityForSell = 0.0;
          for (int x = 0; x < filteredNameForSell.length; x++) {
            sumQuantityForSell += double.parse(filterQuantityForSell[x]);
          }
          var filteredName = storageList
              .where((element) => element.itemName == FilterName[index])
              .toSet();
          var filterPrice = filteredName.map((e) => e.itemPrice).toList();
          var sortedPrice = filterPrice;
          var sumPrice = sortedPrice.last;
          var filterQuantity = filteredName.map((e) => e.itemQuantity).toList();
          var sumQuantity = 0.0;
          for (int x = 0; x < filteredName.length; x++) {
            sumQuantity += double.parse(filterQuantity[x]);
          }
          double remainingQuantity = sumQuantity - sumQuantityForSell;
          newLabour.add(
            StoragePDFReport(
              id: storageList[index].id.toString(),
              price: sumPrice,
              name: FilterName[index],
              quantity: remainingQuantity.toString(),
              date: DateFormat.yMMMEd().format(
                DateTime.parse(storageList[index].itemDate),
              ),
            ),
          );

          Provider.of<FileHandlerForStorage>(context, listen: false).fileList =
              newLabour;
          return GestureDetector(
            onTap: () {
              print('index $index');
            },
            child: AnimationConfiguration.staggeredList(
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
                          double totalMinus = Provider.of<ShopModelData>(
                                  context,
                                  listen: false)
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
                                  sumPrice,
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
                                  FilterName[index],
                                  style: storageItemName,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Tot: $sumQuantity',
                                    style: storageItemDate,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    DateFormat.yMMMEd().format(
                                      DateTime.now(),
                                    ),
                                    style: storageItemDate,
                                  ),
                                ],
                              ),
                              trailing: Text(
                                remainingQuantity < 0
                                    ? 'Empty'
                                    : 'x $remainingQuantity',
                                style: TextStyle(
                                  color: remainingQuantity == 0
                                      ? Colors.red
                                      : remainingQuantity < 20
                                          ? Colors.redAccent
                                          : remainingQuantity >= 20 ||
                                                  remainingQuantity < 50
                                              ? Colors.green
                                              : Colors.green[800],
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
            ),
          );
        },
      ),
    );
  }
}
