import 'package:flutter/cupertino.dart';

class StorageExample {
  String id;
  String name;
  String profit;

  StorageExample({
    this.id,
    this.profit,
    this.name,
  });
}

class ExampleClass extends ChangeNotifier {
  //final helper = DatabaseHelper.instance;

  List<StorageExample> fileList = [];

  void addLabour(StorageExample model) {
    fileList.insert(0, model);
    notifyListeners();
  }

  void removeLabour(int id) {
    fileList.removeAt(id);
    notifyListeners();
  }
}
