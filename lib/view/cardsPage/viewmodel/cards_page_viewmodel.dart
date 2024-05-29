import 'dart:math';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../core/constants/enums/locale_keys_enum.dart';
import '../../../core/init/cache/locale_manager.dart';
import '../model/card_model/card_model.dart';
import '../model/my_card_model/my_card_model.dart';
import '../model/storie_model/storie_model.dart';
import '../provider/card_provider.dart';
import '../provider/my_card_provider.dart';
import '../provider/storie_provider.dart';
import '../services/ICardspageService.dart';
import '../services/cardspage_service.dart';

part 'cards_page_viewmodel.g.dart';

class CardsPageViewmodel = CardsPageViewmodelBase with _$CardsPageViewmodel;

abstract class CardsPageViewmodelBase with Store, BaseViewModel {
  late ICardspageService cardspageService;
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();
  late PageController pageController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController barcodeController;
  late TextEditingController searchCardController;
  @observable
  int currentScreen = 0;

  @action
  void setCurrentScreen(int screen) {
    currentScreen = screen;
  }

  void setContext(BuildContext context) => myContext = context;

  void init() {
    pageController = PageController();
    cardspageService =
        CardspageService(vexanaManager!.networkManager, scaffoldMessengerKey);
    barcodeController = TextEditingController();
    searchCardController = TextEditingController();
  }

  @observable
  bool isLoadingMyCards = false;
  bool isMyCardsFetchBefore = false;
  @action
  void isLoadingMyCardsChange() {
    if (isMyCardsFetchBefore) {
      isLoadingMyCards = !isLoadingMyCards;
      isMyCardsFetchBefore = true;
    }
  }

  @action
  Future<void> getMyCards() async {
    if (LocaleManager.instance
        .getStringValue(PreferencesKeys.TOKEN)
        .isNotEmpty) {
      isLoadingMyCardsChange();
      final List<MyCardModel>? response = await cardspageService.getMyCards();
      if (response != null) {
        final myCardProvider =
            Provider.of<MyCardProvider>(myContext!, listen: false);
        myCardProvider.setMyCardList(response);
      }
      isLoadingMyCardsChange();
    }
  }

  @observable
  CardModel? selectedCard;

  @action
  void setSelectedCard(CardModel? card) {
    selectedCard = card;
  }

  @observable
  bool isCardNumberError = false;

  @action
  void setisCardNumberError(bool newisCardNumberError) {
    isCardNumberError = newisCardNumberError;
  }

  @observable
  MyCardModel? addedCardModel;

  @action
  void setnewAddedCardModel(MyCardModel? newmyCardModel) {
    addedCardModel = newmyCardModel;
  }

  @observable
  bool isLoadingCreateMyCards = false;

  @action
  void isLoadingCreateMyCardsChange() {
    isLoadingCreateMyCards = !isLoadingCreateMyCards;
  }

  @action
  Future<void> createMyCard(
      {required String barcode, required String cardId}) async {
    isLoadingCreateMyCardsChange();
    final MyCardModel? response =
        await cardspageService.createMyCard(barcode: barcode, cardId: cardId);
    if (response != null) {
      setnewAddedCardModel(response);
      final myCardProvider =
          Provider.of<MyCardProvider>(myContext!, listen: false);
      List<MyCardModel>? myCardList = myCardProvider.getMyCardList;
      myCardList?.insert(0, response);
      myCardProvider.setMyCardList(myCardList);
      barcodeController.clear();
      await pageController.animateToPage(2,
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
    }
    isLoadingCreateMyCardsChange();
  }

  @observable
  bool isLoadingStories = false;
  bool isStoriesFetchBefore = false;
  @action
  void isLoadingStoriesChange() {
    if (isLoadingStories) {
      isLoadingStories = !isLoadingStories;
      isLoadingStories = true;
    }
  }

  @action
  Future<void> getStories() async {
    isLoadingStoriesChange();
    final List<StorieModel>? response = await cardspageService.getStories();
    if (response != null) {
      final StorieProvider storieProvider =
          Provider.of<StorieProvider>(myContext!, listen: false);
      storieProvider.setStorieList(response);
    }
    isLoadingStoriesChange();
  }

  @observable
  bool isLoadingCards = false;

  @action
  void isLoadingCardsChange() {
    isLoadingCards = !isLoadingCards;
  }

  @observable
  List<CardItemAZ> cardItemAZList = [];

  @action
  void setSearchCardList(List<CardModel>? newList) {
    if (newList != null) {
      cardItemAZList = newList
          .map((item) =>
              CardItemAZ(cardModel: item, tag: item.name![0].toUpperCase()))
          .toList();

      SuspensionUtil.sortListBySuspensionTag(cardItemAZList);
      SuspensionUtil.setShowSuspensionStatus(cardItemAZList);
      cardItemAZList.insert(0, CardItemAZ(cardModel: CardModel(), tag: "afav"));
    } else {
      final CardProvider cardProvider =
          Provider.of<CardProvider>(myContext!, listen: false);

      cardItemAZList = cardProvider.getCardList
          .map((item) =>
              CardItemAZ(cardModel: item, tag: item.name![0].toUpperCase()))
          .toList();

      SuspensionUtil.sortListBySuspensionTag(cardItemAZList);
      SuspensionUtil.setShowSuspensionStatus(cardItemAZList);
      cardItemAZList.insert(0, CardItemAZ(cardModel: CardModel(), tag: "afav"));
    }
  }

  @action
  Future<void> getCards() async {
    isLoadingCardsChange();
    final List<CardModel>? response = await cardspageService.getCards();
    if (response != null) {
      final CardProvider cardProvider =
          Provider.of<CardProvider>(myContext!, listen: false);
      cardProvider.setCards(response);

      cardItemAZList = response
          .map((item) =>
              CardItemAZ(cardModel: item, tag: item.name![0].toUpperCase()))
          .toList();

      SuspensionUtil.sortListBySuspensionTag(cardItemAZList);
      SuspensionUtil.setShowSuspensionStatus(cardItemAZList);

      cardItemAZList.insert(0, CardItemAZ(cardModel: CardModel(), tag: "afav"));
    }
    isLoadingCardsChange();
    if (response!.length > 6) {
      generateRandomList(response);
    } else {
      randomCards = response;
    }
  }

  @observable
  List<CardModel> randomCards = [];

  @action
  void generateRandomList(List<CardModel> cardList) {
    List<CardModel> randomElements = [];

    Random random = Random();

    while (randomElements.length < 6) {
      int randomIndex = random.nextInt(cardList.length);
      CardModel randomElement = cardList[randomIndex];

      if (!randomElements.contains(randomElement)) {
        randomElements.add(randomElement);
      }
    }
    randomCards = randomElements;
  }
}
