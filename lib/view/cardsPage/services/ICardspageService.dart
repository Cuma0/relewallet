// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:relewallet/view/cardsPage/model/card_model/card_model.dart';
import 'package:vexana/vexana.dart';

import '../model/my_card_model/my_card_model.dart';
import '../model/storie_model/storie_model.dart';

abstract class ICardspageService {
  final INetworkManager manager;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  ICardspageService(this.manager, this.scaffoldMessengerKey);

  Future<List<StorieModel>?> getStories();

  Future<List<MyCardModel>?> getMyCards();

  Future<MyCardModel?> createMyCard(
      {required String barcode, required String cardId});

  Future<List<CardModel>?> getCards();
}
