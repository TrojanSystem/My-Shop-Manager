import 'package:example/model/shop_model.dart';
import 'package:flutter/material.dart';

import '../backend/shop_model_database.dart';

class ShopModelData extends ChangeNotifier {
  DatabaseShopStore db = DatabaseShopStore();
  double totalPrice = 0;
  double totalIncomePrice = 0;

  bool _isLoading = true;

  List<ShopModel> _shopList = [];

  List<ShopModel> get shopList => _shopList;

  bool get isLoading => _isLoading;

  Future loadShopList() async {
    _isLoading = true;
    notifyListeners();
    _shopList = await db.getTasks();
    _isLoading = false;
    notifyListeners();
  }

  Future addShopList(ShopModel task) async {
    await db.insertTask(task);
    await loadShopList();
    notifyListeners();
  }

  Future updateShopList(ShopModel task) async {
    await db.updateTaskList(task);
    await loadShopList();
    notifyListeners();
  }

  Future deleteShopList(int task) async {
    await db.deleteTask(task);
    await loadShopList();
    notifyListeners();
  }

  double addTotalPrice(price, isIncome) {
    if (isIncome == false) {
      totalPrice += price;
      return totalPrice;
    } else {
      totalIncomePrice += price;
      return totalIncomePrice;
    }
  }

  double minusTotalPrice(double price, bool isIncome) {
    if (isIncome == false) {
      totalIncomePrice = totalIncomePrice - price;
      return totalIncomePrice;
    } else {
      totalPrice = totalPrice - price;
      return totalPrice;
    }
  }

  double updateTotalPrice(double price, double updatePrice, bool isIncome) {
    if (isIncome == false) {
      totalIncomePrice -= price;
      totalIncomePrice += updatePrice;
      return totalIncomePrice;
    } else {
      totalPrice -= price;
      totalPrice += updatePrice;
      return totalPrice;
    }
  }
}
