import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class StorageListItem extends StatelessWidget {
  final List storageList;
  StorageListItem({this.storageList});

  // final int index;

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return AnimationLimiter(
      child: ListView.builder(
        padding: EdgeInsets.all(_w / 30),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: storageList.length,
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
                                storageList[index].itemName,
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
                              'x ${storageList[index].itemQuantity}',
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
