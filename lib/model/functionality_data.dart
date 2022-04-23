import 'package:flutter/material.dart';

class FunctionalityData extends ChangeNotifier {
  int currentIndex = 0;

  void changeIndexValue(newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}
