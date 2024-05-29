import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../cardsPage/model/my_card_model/my_card_model.dart';
import '../../cardsPage/provider/my_card_provider.dart';
import '../model/update_my_card_model.dart';
import '../services/IMyCardInfopageService.dart';
import '../services/my_card_info_page_service.dart';

part 'my_card_info_page_viewmodel.g.dart';

class MyCardInfoPageViewmodel = MyCardInfoPageViewmodelBase
    with _$MyCardInfoPageViewmodel;

abstract class MyCardInfoPageViewmodelBase with Store, BaseViewModel {
  late IMyCardInfopageService myCardInfopageService;
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController barcodeController;
  void setContext(BuildContext context) => myContext = context;
  void init(String? initialValue) {
    myCardInfopageService = MyCardInfopageService(
        vexanaManager!.networkManager, scaffoldMessengerKey);
    barcodeController = TextEditingController(text: initialValue);
  }

  @observable
  bool isLoadingUpdate = false;

  @action
  void isLoadingUpdateChange() {
    isLoadingUpdate = !isLoadingUpdate;
  }

  @observable
  String? newBarcodeNo;

  @action
  void setNewBarcodeNo(String newNo) {
    newBarcodeNo = newNo;
  }

  Future<void> updateMyCard(UpdateMyCardModel updateMyCardModel) async {
    isLoadingUpdateChange();
    final response =
        await myCardInfopageService.updateMyCard(updateMyCardModel);
    if (response) {
      final myCardProvider =
          Provider.of<MyCardProvider>(myContext!, listen: false);
      List<MyCardModel>? myCardList = myCardProvider.getMyCardList;
      if (myCardList != null) {
        MyCardModel? myCardOnList = myCardList
            .firstWhere((element) => element.id == updateMyCardModel.myCardId);

        myCardList.remove(myCardOnList);
        myCardOnList.barcode = updateMyCardModel.barcode;

        myCardList.insert(0, myCardOnList);

        myCardProvider.setMyCardList(myCardList);
        setNewBarcodeNo(updateMyCardModel.barcode!);
      }
    }
    isLoadingUpdateChange();
  }

  @observable
  bool isLoadingDelete = false;

  @action
  void isLoadingDeleteChange() {
    isLoadingDelete = !isLoadingDelete;
  }

  Future<void> deleteMyCard(UpdateMyCardModel updateMyCardModel) async {
    isLoadingDeleteChange();
    final response =
        await myCardInfopageService.deleteMyCard(updateMyCardModel);
    if (response) {
      final myCardProvider =
          Provider.of<MyCardProvider>(myContext!, listen: false);
      List<MyCardModel>? myCardList = myCardProvider.getMyCardList;
      if (myCardList != null) {
        MyCardModel? myCardOnList = myCardList
            .firstWhere((element) => element.id == updateMyCardModel.myCardId);

        myCardList.remove(myCardOnList);

        myCardProvider.setMyCardList(myCardList);
      }
      Navigator.of(myContext!, rootNavigator: true).pop();
    }
    isLoadingDeleteChange();
  }
}
