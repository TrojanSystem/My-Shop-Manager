import 'package:flutter/material.dart';

class FunctionalityData extends ChangeNotifier {
  int currentIndex = 0;
  double currentQuantity = 0;
  double totalPrice = 0;
  double totalIncomePrice = 0;

  void changeIndexValue(newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }

  double minusTotalPrice(double price) {
    totalPrice = totalPrice - price;
    return totalPrice;
  }

  double updateTotalPrice(double price, double updatePrice) {
    totalPrice -= price;
    totalPrice += updatePrice;
    return totalPrice;
  }
}
