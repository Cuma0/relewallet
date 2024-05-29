import 'package:flutter/material.dart';

import '../model/my_card_model/my_card_model.dart';

class MyCardProvider extends ChangeNotifier {
  List<MyCardModel>? _listMyCard;

  List<MyCardModel>? get getMyCardList => _listMyCard;

  void setMyCardList(List<MyCardModel>? newMyCardList) {
    _listMyCard = newMyCardList;
    notifyListeners();
  }
}
