import 'package:example/storage/profit_calculator.dart';
import 'package:example/storage/shop_model_data.dart';
import 'package:example/storage/storage_pdf_report.dart';
import 'package:example/storage/update_storage.dart';
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

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    var filterName = storageList.map((e) => e.itemName).toSet().toList();
    var filterNameForSell =
        soldItemList.map((e) => e.itemName).toSet().toList();

    final List<StoragePDFReport> newLabour = [];
    final List<StorageExample> newModel = [];
    return AnimationLimiter(
      child: ListView.builder(
        padding: EdgeInsets.all(_w / 30),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemCount: filterName.length,
        itemBuilder: (BuildContext context, int index) {
          var filteredNameForSell = soldItemList
              .where((element) => element.itemName == filterName[index])
              .toSet();
          var filteredNameForSells = storageList
              .where((element) => element.itemName == filterName[index])
              .toSet();
          var filterPriceForSell =
              filteredNameForSells.map((e) => e.itemPrice).toList();
          var filterPriceForSells =
              filteredNameForSells.map((e) => e.itemQuantity).toList();

          var sumPriceForSell = 0.0;
          for (int x = 0; x < filterPriceForSells.length; x++) {
            sumPriceForSell += (double.parse(filterPriceForSells[x]) *
                double.parse(filterPriceForSell[x]));
          }

          //print(sum[0]);
          var filterQuantityForSell =
              filteredNameForSell.map((e) => e.itemQuantity).toList();
          // Total quantity calculation for the sold items
          var sumQuantityForSell = 0.0;
          for (int x = 0; x < filteredNameForSell.length; x++) {
            sumQuantityForSell += double.parse(filterQuantityForSell[x]);
          }

          var filteredName = storageList
              .where((element) => element.itemName == filterName[index])
              .toList();
          filteredName.sort((a, b) {
            return a.itemDate.compareTo(b.itemDate);
          });
          var filterPrice =
              filteredName.map((e) => e.itemPrice).toSet().toList();

          var totIncomeSum = 0.0;
          var totIncome = 0.0;
          if (filterQuantityForSell.isEmpty) {
            totIncomeSum = 0;
          } else {
            for (int xx = 0; xx < filterPrice.length; xx++) {
              totIncomeSum += (double.parse(filterPrice[xx]) *
                  double.parse(filterQuantityForSell[xx]));
              for (int yy = 0; yy < filterPrice.length; yy++) {
                totIncome += (double.parse(filterPrice[xx]) *
                    double.parse(filterQuantityForSell[yy]));
              }
            }
          }

          var sortedPrice = filterPrice;
          var sumPriceLast = sortedPrice.last;

          var sumPrice = sortedPrice.first;

          var fixedPrice = 0.0;
          if (double.parse(sumPriceLast) > double.parse(sumPrice)) {
            var diffrenceBetweenPrice =
                double.parse(sumPriceLast) - double.parse(sumPrice);
            fixedPrice = double.parse(sumPriceLast) - diffrenceBetweenPrice;
          } else if (double.parse(sumPriceLast) == double.parse(sumPrice)) {
            fixedPrice = double.parse(sumPriceLast);
          } else {
            var diffrenceBetweenPrice =
                double.parse(sumPrice) - double.parse(sumPriceLast);
            fixedPrice = double.parse(sumPriceLast) + diffrenceBetweenPrice;
          }

          // Total quantity calculation for the storage items
          var filterQuantity = filteredName.map((e) => e.itemQuantity).toList();

          var sumQuantity = 0.0;
          for (int x = 0; x < filteredName.length; x++) {
            sumQuantity += double.parse(filterQuantity[x]);
          }
          double remainingQuantity = sumQuantity - sumQuantityForSell;

          final soldQuantity = sumQuantity - remainingQuantity;
          var profitSum = 0.0;
          profitSum = totIncomeSum;

          newLabour.add(
            StoragePDFReport(
              id: storageList[index].id.toString(),
              price: sumPrice,
              name: filterName[index],
              quantity: remainingQuantity.toString(),
              date: DateFormat.yMMMEd().format(
                DateTime.parse(storageList[index].itemDate),
              ),
            ),
          );

          newModel.add(
            StorageExample(
              id: storageList[index].id.toString(),
              name: filterName[index],
              profit: profitSum.toString(),
            ),
          );
          Provider.of<ExampleClass>(context, listen: false).fileList = newModel;
          Provider.of<FileHandlerForStorage>(context, listen: false).fileList =
              newLabour;
          return GestureDetector(
            onTap: () {},
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
                                  sortedPrice.last.toString(),
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
                                  filterName[index],
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
                                      DateTime.parse(
                                          storageList[index].itemDate),
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
