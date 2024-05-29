// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cards_page_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CardsPageViewmodel on CardsPageViewmodelBase, Store {
  late final _$currentScreenAtom =
      Atom(name: 'CardsPageViewmodelBase.currentScreen', context: context);

  @override
  int get currentScreen {
    _$currentScreenAtom.reportRead();
    return super.currentScreen;
  }

  @override
  set currentScreen(int value) {
    _$currentScreenAtom.reportWrite(value, super.currentScreen, () {
      super.currentScreen = value;
    });
  }

  late final _$isLoadingMyCardsAtom =
      Atom(name: 'CardsPageViewmodelBase.isLoadingMyCards', context: context);

  @override
  bool get isLoadingMyCards {
    _$isLoadingMyCardsAtom.reportRead();
    return super.isLoadingMyCards;
  }

  @override
  set isLoadingMyCards(bool value) {
    _$isLoadingMyCardsAtom.reportWrite(value, super.isLoadingMyCards, () {
      super.isLoadingMyCards = value;
    });
  }

  late final _$selectedCardAtom =
      Atom(name: 'CardsPageViewmodelBase.selectedCard', context: context);

  @override
  CardModel? get selectedCard {
    _$selectedCardAtom.reportRead();
    return super.selectedCard;
  }

  @override
  set selectedCard(CardModel? value) {
    _$selectedCardAtom.reportWrite(value, super.selectedCard, () {
      super.selectedCard = value;
    });
  }

  late final _$isCardNumberErrorAtom =
      Atom(name: 'CardsPageViewmodelBase.isCardNumberError', context: context);

  @override
  bool get isCardNumberError {
    _$isCardNumberErrorAtom.reportRead();
    return super.isCardNumberError;
  }

  @override
  set isCardNumberError(bool value) {
    _$isCardNumberErrorAtom.reportWrite(value, super.isCardNumberError, () {
      super.isCardNumberError = value;
    });
  }

  late final _$addedCardModelAtom =
      Atom(name: 'CardsPageViewmodelBase.addedCardModel', context: context);

  @override
  MyCardModel? get addedCardModel {
    _$addedCardModelAtom.reportRead();
    return super.addedCardModel;
  }

  @override
  set addedCardModel(MyCardModel? value) {
    _$addedCardModelAtom.reportWrite(value, super.addedCardModel, () {
      super.addedCardModel = value;
    });
  }

  late final _$isLoadingCreateMyCardsAtom = Atom(
      name: 'CardsPageViewmodelBase.isLoadingCreateMyCards', context: context);

  @override
  bool get isLoadingCreateMyCards {
    _$isLoadingCreateMyCardsAtom.reportRead();
    return super.isLoadingCreateMyCards;
  }

  @override
  set isLoadingCreateMyCards(bool value) {
    _$isLoadingCreateMyCardsAtom
        .reportWrite(value, super.isLoadingCreateMyCards, () {
      super.isLoadingCreateMyCards = value;
    });
  }

  late final _$isLoadingStoriesAtom =
      Atom(name: 'CardsPageViewmodelBase.isLoadingStories', context: context);

  @override
  bool get isLoadingStories {
    _$isLoadingStoriesAtom.reportRead();
    return super.isLoadingStories;
  }

  @override
  set isLoadingStories(bool value) {
    _$isLoadingStoriesAtom.reportWrite(value, super.isLoadingStories, () {
      super.isLoadingStories = value;
    });
  }

  late final _$isLoadingCardsAtom =
      Atom(name: 'CardsPageViewmodelBase.isLoadingCards', context: context);

  @override
  bool get isLoadingCards {
    _$isLoadingCardsAtom.reportRead();
    return super.isLoadingCards;
  }

  @override
  set isLoadingCards(bool value) {
    _$isLoadingCardsAtom.reportWrite(value, super.isLoadingCards, () {
      super.isLoadingCards = value;
    });
  }

  late final _$cardItemAZListAtom =
      Atom(name: 'CardsPageViewmodelBase.cardItemAZList', context: context);

  @override
  List<CardItemAZ> get cardItemAZList {
    _$cardItemAZListAtom.reportRead();
    return super.cardItemAZList;
  }

  @override
  set cardItemAZList(List<CardItemAZ> value) {
    _$cardItemAZListAtom.reportWrite(value, super.cardItemAZList, () {
      super.cardItemAZList = value;
    });
  }

  late final _$randomCardsAtom =
      Atom(name: 'CardsPageViewmodelBase.randomCards', context: context);

  @override
  List<CardModel> get randomCards {
    _$randomCardsAtom.reportRead();
    return super.randomCards;
  }

  @override
  set randomCards(List<CardModel> value) {
    _$randomCardsAtom.reportWrite(value, super.randomCards, () {
      super.randomCards = value;
    });
  }

  late final _$getMyCardsAsyncAction =
      AsyncAction('CardsPageViewmodelBase.getMyCards', context: context);

  @override
  Future<void> getMyCards() {
    return _$getMyCardsAsyncAction.run(() => super.getMyCards());
  }

  late final _$createMyCardAsyncAction =
      AsyncAction('CardsPageViewmodelBase.createMyCard', context: context);

  @override
  Future<void> createMyCard({required String barcode, required String cardId}) {
    return _$createMyCardAsyncAction
        .run(() => super.createMyCard(barcode: barcode, cardId: cardId));
  }

  late final _$getStoriesAsyncAction =
      AsyncAction('CardsPageViewmodelBase.getStories', context: context);

  @override
  Future<void> getStories() {
    return _$getStoriesAsyncAction.run(() => super.getStories());
  }

  late final _$getCardsAsyncAction =
      AsyncAction('CardsPageViewmodelBase.getCards', context: context);

  @override
  Future<void> getCards() {
    return _$getCardsAsyncAction.run(() => super.getCards());
  }

  late final _$CardsPageViewmodelBaseActionController =
      ActionController(name: 'CardsPageViewmodelBase', context: context);

  @override
  void setCurrentScreen(int screen) {
    final _$actionInfo = _$CardsPageViewmodelBaseActionController.startAction(
        name: 'CardsPageViewmodelBase.setCurrentScreen');
    try {
      return super.setCurrentScreen(screen);
    } finally {
      _$CardsPageViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isLoadingMyCardsChange() {
    final _$actionInfo = _$CardsPageViewmodelBaseActionController.startAction(
        name: 'CardsPageViewmodelBase.isLoadingMyCardsChange');
    try {
      return super.isLoadingMyCardsChange();
    } finally {
      _$CardsPageViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedCard(CardModel? card) {
    final _$actionInfo = _$CardsPageViewmodelBaseActionController.startAction(
        name: 'CardsPageViewmodelBase.setSelectedCard');
    try {
      return super.setSelectedCard(card);
    } finally {
      _$CardsPageViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setisCardNumberError(bool newisCardNumberError) {
    final _$actionInfo = _$CardsPageViewmodelBaseActionController.startAction(
        name: 'CardsPageViewmodelBase.setisCardNumberError');
    try {
      return super.setisCardNumberError(newisCardNumberError);
    } finally {
      _$CardsPageViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setnewAddedCardModel(MyCardModel? newmyCardModel) {
    final _$actionInfo = _$CardsPageViewmodelBaseActionController.startAction(
        name: 'CardsPageViewmodelBase.setnewAddedCardModel');
    try {
      return super.setnewAddedCardModel(newmyCardModel);
    } finally {
      _$CardsPageViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isLoadingCreateMyCardsChange() {
    final _$actionInfo = _$CardsPageViewmodelBaseActionController.startAction(
        name: 'CardsPageViewmodelBase.isLoadingCreateMyCardsChange');
    try {
      return super.isLoadingCreateMyCardsChange();
    } finally {
      _$CardsPageViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isLoadingStoriesChange() {
    final _$actionInfo = _$CardsPageViewmodelBaseActionController.startAction(
        name: 'CardsPageViewmodelBase.isLoadingStoriesChange');
    try {
      return super.isLoadingStoriesChange();
    } finally {
      _$CardsPageViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isLoadingCardsChange() {
    final _$actionInfo = _$CardsPageViewmodelBaseActionController.startAction(
        name: 'CardsPageViewmodelBase.isLoadingCardsChange');
    try {
      return super.isLoadingCardsChange();
    } finally {
      _$CardsPageViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchCardList(List<CardModel>? newList) {
    final _$actionInfo = _$CardsPageViewmodelBaseActionController.startAction(
        name: 'CardsPageViewmodelBase.setSearchCardList');
    try {
      return super.setSearchCardList(newList);
    } finally {
      _$CardsPageViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void generateRandomList(List<CardModel> cardList) {
    final _$actionInfo = _$CardsPageViewmodelBaseActionController.startAction(
        name: 'CardsPageViewmodelBase.generateRandomList');
    try {
      return super.generateRandomList(cardList);
    } finally {
      _$CardsPageViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentScreen: ${currentScreen},
isLoadingMyCards: ${isLoadingMyCards},
selectedCard: ${selectedCard},
isCardNumberError: ${isCardNumberError},
addedCardModel: ${addedCardModel},
isLoadingCreateMyCards: ${isLoadingCreateMyCards},
isLoadingStories: ${isLoadingStories},
isLoadingCards: ${isLoadingCards},
cardItemAZList: ${cardItemAZList},
randomCards: ${randomCards}
    ''';
  }
}
