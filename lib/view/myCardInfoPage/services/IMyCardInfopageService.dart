// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:vexana/vexana.dart';

import '../model/update_my_card_model.dart';

abstract class IMyCardInfopageService {
  final INetworkManager manager;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  IMyCardInfopageService(this.manager, this.scaffoldMessengerKey);

  Future<bool> updateMyCard(UpdateMyCardModel updateMyCardModel);

  Future<bool> deleteMyCard(UpdateMyCardModel updateMyCardModel);
}
