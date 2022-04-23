import 'package:example/backend/expense_database.dart';
import 'package:example/model/shop_model.dart';
import 'package:flutter/cupertino.dart';

class ExpensesData extends ChangeNotifier {
  DatabaseExpense db = DatabaseExpense();
  double totalPrice = 0;
  double totalIncomePrice = 0;

  bool _isLoading = true;

  List<ShopModel> _expenseList = [];

  List<ShopModel> get expenseList => _expenseList;

  bool get isLoading => _isLoading;

  Future loadExpenseList() async {
    _isLoading = true;
    notifyListeners();
    _expenseList = await db.getTasks();
    _isLoading = false;
    notifyListeners();
  }

  Future addExpenseList(ShopModel task) async {
    await db.insertTask(task);
    await loadExpenseList();
    notifyListeners();
  }

  Future updateExpenseList(ShopModel task) async {
    await db.updateTaskList(task);
    await loadExpenseList();
    notifyListeners();
  }

  Future deleteExpenseList(int task) async {
    await db.deleteTask(task);
    await loadExpenseList();
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
