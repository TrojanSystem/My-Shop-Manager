import 'package:example/model/daily_sell_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/shop_model.dart';

class UpdateDailySell extends StatefulWidget {
  final int index;
  final String existedItemPrice;
  final String existedItemName;
  final String existedItemDate;
  final String existedItemQuantity;

  UpdateDailySell(
      {this.index,
      this.existedItemQuantity,
      this.existedItemDate,
      this.existedItemName,
      this.existedItemPrice});

  @override
  State<UpdateDailySell> createState() => _UpdateDailySellState();
}

class _UpdateDailySellState extends State<UpdateDailySell> {
  final formKey = GlobalKey<FormState>();

  String updateItemName = '';
  String updateItemQuantity = '';
  double updateItemPrice = 0;
  String updateDateTime = DateTime.now().toString();

  void datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      firstDate: DateTime(DateTime.now().month + 1),
    ).then((value) => setState(() {
          if (value != null) {
            updateDateTime = value.toString();
          } else {
            updateDateTime = DateTime.now().toString();
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        title: const Text(
          'Update Daily Sell',
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            const Divider(color: Colors.grey, thickness: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 28, 18, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Item Name',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: widget.existedItemName,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Item Name can\'t be empty';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      updateItemName = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter the Item Name',
                      filled: true,
                      fillColor: Colors.grey[200],
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Item Quantity',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: widget.existedItemQuantity,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Item Quantity can\'t be empty';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      updateItemQuantity = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter the Item Quantity',
                      filled: true,
                      fillColor: Colors.grey[200],
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Item Price',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: widget.existedItemPrice,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Item Price can\'t be empty';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      updateItemPrice = double.parse(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter the Item Price',
                      filled: true,
                      fillColor: Colors.grey[200],
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 28, 18, 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        datePicker();
                      });
                    },
                    icon: const Icon(Icons.calendar_today),
                  ),
                  Text(
                    DateFormat.yMEd().format(DateTime.parse(updateDateTime)),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  double total =
                      Provider.of<DailySellData>(context, listen: false)
                          .updateTotalPrice(
                              double.parse(widget.existedItemPrice),
                              updateItemPrice);
                  var updateModel = ShopModel(
                    id: widget.index,
                    itemDate: updateDateTime,
                    itemName: updateItemName,
                    itemPrice: updateItemPrice.toStringAsFixed(2),
                    itemQuantity: updateItemQuantity,
                    total: total.toStringAsFixed(2),
                  );
                  Provider.of<DailySellData>(context, listen: false)
                      .updateShopListDailySellList(updateModel);
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                width: double.infinity,
                height: 60.0,
                decoration: BoxDecoration(
                  color: Colors.green[500],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const Center(
                  child: Text(
                    'Update Sold Item',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
