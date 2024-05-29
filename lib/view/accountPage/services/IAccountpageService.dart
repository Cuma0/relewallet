// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:vexana/vexana.dart';

import '../model/sign_in_response_model/sign_in_response_model.dart';
import '../model/sign_in_with_apple_model/sign_in_with_apple_model.dart';
import '../model/sign_in_with_google_model/sign_in_with_google_model.dart';
import '../model/sign_up_with_mail_model/sign_up_with_mail_model.dart';

abstract class IAccountpageService {
  final INetworkManager manager;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  IAccountpageService(this.manager, this.scaffoldMessengerKey);

  Future<SignInResponseModel?> signInWithGoogle(
      SignInWithGoogleModel signInWithGoogleModel);

  Future<SignInResponseModel?> signInWithMail(
      SignUpWithMailModel signUpWithMailModel);

  Future<SignInResponseModel?> signUpWithMail(
      SignUpWithMailModel signUpWithMailModel);

  Future<bool?> deleteUser();

  Future<SignInResponseModel?> signInWithApple(
      SignInWithAppleModel signInWithAppleModel);
}
