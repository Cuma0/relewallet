// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:vexana/vexana.dart';

import '../model/offer_model.dart';

abstract class IOfferspageService {
  final INetworkManager manager;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  IOfferspageService(this.manager, this.scaffoldMessengerKey);

  Future<List<OfferModel>?> getOffers({required String lang});
}
