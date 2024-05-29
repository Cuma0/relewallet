import 'package:flutter/material.dart';

import '../model/card_model/card_model.dart';

class CardProvider extends ChangeNotifier {
  late List<CardModel> _listCard;

  List<CardModel> get getCardList => _listCard;

  void setCards(List<CardModel> newCardList) {
    _listCard = newCardList;
    notifyListeners();
  }
}
