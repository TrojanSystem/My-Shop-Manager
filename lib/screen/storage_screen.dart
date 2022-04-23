import 'package:example/item/drawer_item.dart';
import 'package:example/model/shop_model_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../input_form/add_storage.dart';
import '../item/add_button_item.dart';
import '../item/storage_list_item.dart';

class StorageScreen extends StatelessWidget {
  const StorageScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 38.0, right: 30),
                child: AddButton(
                  navigateToPage: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const AddStorageList(),
                      ),
                    );
                  },
                  colour: Colors.white,
                ),
              ),
            ],
          ),
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
                : StorageListItem(storageList: data.shopList),
        drawer: DrawerItem(),
      ),
    );
  }
}
