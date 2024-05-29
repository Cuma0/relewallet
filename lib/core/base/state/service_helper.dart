import 'package:flutter/material.dart';
import 'package:vexana/vexana.dart';

mixin ServiceHelper {
  void showMessage({
    GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey,
    IErrorModel? errorModel,
    required BuildContext context,
  }) {
    if (scaffoldMessengerKey == null || errorModel == null) return;

    scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
      content: Text(
        errorModel.description ?? errorModel.statusCode.toString(),
        style: const TextStyle(color: Colors.black),
      ),
    ));
  }
}
