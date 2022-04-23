import 'package:example/backend/daily_sell_database.dart';
import 'package:example/model/shop_model.dart';
import 'package:flutter/cupertino.dart';

class DailySellData extends ChangeNotifier {
  DatabaseDailySell db = DatabaseDailySell();
  double totalPrice = 0;
  double totalIncomePrice = 0;

  bool _isLoading = true;

  List<ShopModel> _dailySellList = [];

  List<ShopModel> get dailySellList => _dailySellList;

  bool get isLoading => _isLoading;

  Future loadDailySellList() async {
    _isLoading = true;
    notifyListeners();
    _dailySellList = await db.getTasks();
    _isLoading = false;
    notifyListeners();
  }

  Future addDailySellList(ShopModel task) async {
    await db.insertTask(task);
    await loadDailySellList();
    notifyListeners();
  }

  Future updateShopListDailySellList(ShopModel task) async {
    await db.updateTaskList(task);
    await loadDailySellList();
    notifyListeners();
  }

  Future deleteDailySellList(int task) async {
    await db.deleteTask(task);
    await loadDailySellList();
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
