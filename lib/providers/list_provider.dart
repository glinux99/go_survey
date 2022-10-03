import 'package:flutter/cupertino.dart';

class ListProvider with ChangeNotifier {
  List<String> list = [];

  void AjouterElement(String element) {
    list.add(element);
    notifyListeners();
  }

  void SuppElement(int index) {
    list.removeAt(index);
    notifyListeners();
  }
}
