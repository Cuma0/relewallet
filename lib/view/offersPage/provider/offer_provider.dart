import 'package:flutter/material.dart';

import '../model/offer_model.dart';

class OfferProvider extends ChangeNotifier {
  late List<OfferModel> _listOffer = [];

  List<OfferModel> get getOfferList => _listOffer;

  void setOfferList(List<OfferModel> newOfferList) {
    _listOffer = newOfferList;
    notifyListeners();
  }
}
