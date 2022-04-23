import 'package:example/input_form/update_storage.dart';
import 'package:example/model/shop_model_data.dart';
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

  StorageListItem({this.storageList});

  // final int index;

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    var FilterName = storageList.map((e) => e.itemName).toSet().toList();

    return AnimationLimiter(
      child: ListView.builder(
        padding: EdgeInsets.all(_w / 30),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: FilterName.length,
        itemBuilder: (BuildContext context, int index) {
          // final quantity = Provider.of<ShopModelData>(context).shopList;
          // final adjustedQuantity = Provider.of<ShopModelData>(context)
          //     .quantityManipulation(quantity, storageList[index].itemQuantity);

          var filteredName = storageList
              .where((element) => element.itemName == FilterName[index])
              .toSet();
          var filterPrice = filteredName.map((e) => e.itemPrice).toList();
          var sumPrice = 0.0;
          for (int x = 0; x < filteredName.length; x++) {
            sumPrice += double.parse(filterPrice[x]);
          }
          var filterQuantity = filteredName.map((e) => e.itemQuantity).toList();
          var sumQuantity = 0.0;
          for (int x = 0; x < filteredName.length; x++) {
            sumQuantity += double.parse(filterQuantity[x]);
          }

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
                                sumPrice.toStringAsFixed(2),
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
                            borderRadius: BorderRadius.circular(30),
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
                            subtitle: Text(
                              DateFormat.yMMMEd().format(
                                DateTime.now(),
                              ),
                              style: storageItemDate,
                            ),
                            trailing: Text(
                              'x ${sumQuantity}',
                              style: storageItemQuantity,
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
