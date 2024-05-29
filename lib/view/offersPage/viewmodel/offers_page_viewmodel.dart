import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../../core/base/model/base_view_model.dart';
import '../model/offer_model.dart';
import '../provider/offer_provider.dart';
import '../services/IOfferspageService.dart';
import '../services/offerspage_service.dart';

part 'offers_page_viewmodel.g.dart';

class OffersPageViewmodel = OffersPageViewmodelBase with _$OffersPageViewmodel;

abstract class OffersPageViewmodelBase with Store, BaseViewModel {
  late IOfferspageService offerspageService;
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();
  void setContext(BuildContext context) => myContext = context;

  void init() {
    offerspageService =
        OfferspageService(vexanaManager!.networkManager, scaffoldMessengerKey);
  }

  @observable
  bool isLoadingOffers = false;

  bool isOffersFetchBefore = false;
  @action
  void isLoadingOffersChange() {
    if (isOffersFetchBefore) {
      isLoadingOffers = !isLoadingOffers;
      isOffersFetchBefore = true;
    }
  }

  Future<void> getOfferList() async {
    isLoadingOffersChange();
    List<OfferModel>? response = await offerspageService.getOffers(lang: "tr");
    if (response != null) {
      final OfferProvider offerProvider =
          Provider.of<OfferProvider>(myContext!, listen: false);
      offerProvider.setOfferList(response);
    }
    isLoadingOffersChange();
  }
}
