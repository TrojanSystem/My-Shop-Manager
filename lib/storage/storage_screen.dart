import 'package:example/item/drawer_item.dart';
import 'package:example/sold_items_data/daily_sell_data.dart';
import 'package:example/storage/shop_model_data.dart';
import 'package:example/storage/storage_pdf_report.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../item/drop_down_menu_button.dart';
import '../profit_analysis/profit_analysis_screen.dart';
import 'add_storage.dart';
import 'storage_list_item.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({Key key}) : super(key: key);

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  @override
  Widget build(BuildContext context) {
    final yearFilter = Provider.of<ShopModelData>(context).shopList;

    final result = yearFilter
        .where((element) =>
            DateTime.parse(element.itemDate).year == DateTime.now().year)
        .toList();
    final yearFilterForSell = Provider.of<DailySellData>(context).dailySellList;
    final resultForSell = yearFilterForSell
        .where((element) =>
            DateTime.parse(element.itemDate).year == DateTime.now().year)
        .toList();

    return Consumer<ShopModelData>(
      builder: (context, data, child) => Scaffold(
        backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
          title: const Text(
            'Storage',
            style: storageTitle,
          ),
          elevation: 0,
          toolbarHeight: 90,
        ),
        body: data.shopList.isEmpty
            ? const Center(
                child: Text(
                  'Storage Empty!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              )
            : data.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  )
                : StorageListItem(
                    storageList: result, soldItemList: resultForSell),
        drawer: DrawerItem(),
        floatingActionButton: Builder(
          builder: (context) => DropDownMenuButton(
            primaryColor: const Color.fromRGBO(3, 83, 151, 1),
            button_1: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AddStorageList(),
                ),
              );
            },
            button_2: () {
              setState(() {
                Provider.of<FileHandlerForStorage>(context, listen: false)
                    .createTable();
              });
            },
            button_3: () {
              Scaffold.of(context).openDrawer();
            },
            button_4: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ProfitAnalaysisScreen(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
