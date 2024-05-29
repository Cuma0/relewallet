// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:local_auth/local_auth.dart';
import '../../../../core/constants/enums/locale_keys_enum.dart';
import '../../../../core/extension/context_extension.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/cache/locale_manager.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/theme/light/color_scheme_light.dart';
import '../../viewmodel/account_page_viewmodel.dart';

import '../../../../core/base/view/base_widget.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';

class CardAsisstantView extends StatefulWidget {
  final AccountPageViewmodel viewmodel;
  const CardAsisstantView({super.key, required this.viewmodel});

  @override
  State<CardAsisstantView> createState() => _CardAsisstantViewState();
}

class _CardAsisstantViewState extends State<CardAsisstantView> {
  bool stateLocaleAuth = false;
  bool stateNotifications = false;

  @override
  void initState() {
    super.initState();
    stateLocaleAuth =
        LocaleManager.instance.getBoolValue(PreferencesKeys.LOCALE_AUTH);
    stateNotifications =
        LocaleManager.instance.getBoolValue(PreferencesKeys.NOTIFICATIONS);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AccountPageViewmodel>(
        viewModel: AccountPageViewmodel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onPageBuilder: (BuildContext context, AccountPageViewmodel viewmodel) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Card Asisstant"),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: context.paddingNormalHorizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocaleKeys.settings_page_app_security.locale),
                        CupertinoSwitch(
                          value: stateLocaleAuth,
                          onChanged: (value) async {
                            _checkBiometric().then((isAuth) {
                              if (isAuth) {
                                setState(
                                  () {
                                    stateLocaleAuth = value;
                                    LocaleManager.instance.setBoolValue(
                                        PreferencesKeys.LOCALE_AUTH, value);
                                  },
                                );
                              }
                            });
                          },
                          activeColor: ColorSchemeLight.instance!.blue,
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: context.paddingNormalHorizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocaleKeys.settings_page_notifications.locale),
                        CupertinoSwitch(
                          value: stateNotifications,
                          onChanged: (value) {
                            stateNotifications = value;
                            LocaleManager.instance.setBoolValue(
                                PreferencesKeys.NOTIFICATIONS, value);
                            if (value) {
                              FirebaseMessaging.instance.subscribeToTopic("en");
                            } else {
                              FirebaseMessaging.instance
                                  .unsubscribeFromTopic("en");
                            }
                            setState(
                              () {},
                            );
                          },
                          activeColor: ColorSchemeLight.instance!.blue,
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  context.lowSizedBoxVertical,
                  Padding(
                    padding: context.paddingNormalHorizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys
                              .settings_page_delete_account_content_delete_account
                              .locale,
                        ),
                        Observer(builder: (_) {
                          return viewmodel.isLoadingDeleteUser
                              ? const CircularProgressIndicator()
                              : CupertinoSwitch(
                                  value: false,
                                  onChanged: (value) {
                                    if (value) {
                                      alertDialog(
                                          context, viewmodel, widget.viewmodel);
                                    }
                                  },
                                  activeColor: ColorSchemeLight.instance!.blue,
                                );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<bool> _checkBiometric() async {
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

alertDialog(BuildContext context, AccountPageViewmodel viewmodel,
    AccountPageViewmodel widgetViewmodel) {
  return showDialog(
      context: context,
      builder: (_) {
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text(LocaleKeys
                    .settings_page_delete_account_content_delete_account
                    .locale),
                content: Text(LocaleKeys
                    .settings_page_delete_account_content_delete_account_subtitle
                    .locale),
                actions: <Widget>[
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text(
                      LocaleKeys
                          .settings_page_delete_account_content_cancel.locale,
                      style: context.textTheme.labelLarge!.copyWith(
                        color: CupertinoColors.activeBlue,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text(
                      LocaleKeys
                          .settings_page_delete_account_content_delete.locale,
                      style: context.textTheme.labelLarge!.copyWith(
                        color: CupertinoColors.systemRed,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () async {
                      viewmodel.deleteAccount().then((value) async {
                        if (value) {
                          Navigator.of(context, rootNavigator: false)
                              .pushNamedAndRemoveUntil(
                                  NavigationConstants.DEFAULT,
                                  (Route<dynamic> route) => false);
                        } else {
                          Navigator.of(context, rootNavigator: true).pop();
                        }
                      });
                    },
                  ),
                ],
              )
            : AlertDialog(
                title: Text(LocaleKeys
                    .settings_page_delete_account_content_delete_account
                    .locale),
                content: Text(LocaleKeys
                    .settings_page_delete_account_content_delete_account_subtitle
                    .locale),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      LocaleKeys
                          .settings_page_delete_account_content_cancel.locale,
                      style: context.textTheme.labelLarge!.copyWith(
                        color: CupertinoColors.activeBlue,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                  TextButton(
                    child: Text(
                      LocaleKeys
                          .settings_page_delete_account_content_delete.locale,
                      style: context.textTheme.labelLarge!.copyWith(
                        color: CupertinoColors.systemRed,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () async {
                      viewmodel.deleteAccount().then((value) async {
                        if (value) {
                          Navigator.of(context, rootNavigator: false)
                              .pushNamedAndRemoveUntil(
                                  NavigationConstants.DEFAULT,
                                  (Route<dynamic> route) => false);
                        } else {
                          Navigator.of(context, rootNavigator: true).pop();
                        }
                      });
                    },
                  ),
                ],
              );
      });
}
