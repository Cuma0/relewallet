// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/constants/enums/locale_keys_enum.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../core/init/cache/locale_manager.dart';
import '../../../accountPage/provider/account_provider.dart';
import '../services/ISplashpageService.dart';
import '../services/splashpage_service.dart';

part 'splash_page_viewmodel.g.dart';

class SplashPageViewmodel = SplashPageViewmodelBase with _$SplashPageViewmodel;

abstract class SplashPageViewmodelBase with Store, BaseViewModel {
  late ISplashpageService splashpageService;
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();
  void setContext(BuildContext context) => myContext = context;
  void init() {
    splashpageService =
        SplashpageService(vexanaManager!.networkManager, scaffoldMessengerKey);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final AccountProvider accountProvider =
          Provider.of<AccountProvider>(myContext!, listen: false);

      accountProvider.setUserName(
          LocaleManager.instance.getStringValue(PreferencesKeys.NAME));

      accountProvider.setProfilePic(
          LocaleManager.instance.getStringValue(PreferencesKeys.PHOTO_URL));

      accountProvider.setEmail(
          LocaleManager.instance.getStringValue(PreferencesKeys.EMAIL));

      bool localAuth =
          LocaleManager.instance.getBoolValue(PreferencesKeys.LOCALE_AUTH);

      if (localAuth) {
        checkBiometric().then((value) {
          if (value) {
            Future.delayed(const Duration(seconds: 3)).then((value) {
              Navigator.of(myContext!).pushNamedAndRemoveUntil(
                  NavigationConstants.SCREEN_VIEW, (route) => false);
            });
          }
        });
      } else {
        Future.delayed(const Duration(seconds: 3)).then((value) {
          Navigator.of(myContext!).pushNamedAndRemoveUntil(
              NavigationConstants.SCREEN_VIEW, (route) => false);
        });
      }
    });
  }

  Future<bool> checkBiometric() async {
    final LocalAuthentication auth = LocalAuthentication();
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      Exception(e);
    }

    List<BiometricType>? availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } catch (e) {
      Exception(e);
    }

    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Touch your finger on the sensor to login',
      );
    } catch (e) {
      Exception(e);
    }
    bool isAuth = authenticated ? true : false;
    return isAuth;
  }
}
