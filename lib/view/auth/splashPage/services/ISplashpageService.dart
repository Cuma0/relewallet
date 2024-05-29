// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:vexana/vexana.dart';

abstract class ISplashpageService {
  final INetworkManager manager;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  ISplashpageService(this.manager, this.scaffoldMessengerKey);

  // Future<List<RoomModel>?> getRoom(
  //     String country, String lang, BuildContext context);
}
