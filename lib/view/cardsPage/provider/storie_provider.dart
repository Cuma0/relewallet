import 'package:flutter/material.dart';

import '../model/storie_model/storie_model.dart';

class StorieProvider extends ChangeNotifier {
  late List<StorieModel>? _listStorie = [];

  List<StorieModel>? get getStorieList => _listStorie;

  void setStorieList(List<StorieModel>? newStorieList) {
    _listStorie = newStorieList;
    notifyListeners();
  }
}
