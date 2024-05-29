import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/base/view/base_widget.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/extension/string_extension.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../../../core/theme/light/color_scheme_light.dart';
import '../model/language_model/language_model.dart';
import '../viewmodel/account_page_viewmodel.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({super.key});

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  List<LanguageModel> myLangList = [
    LanguageModel(name: "Türkçe", langCode: "tr"),
    LanguageModel(name: "English", langCode: "en"),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseView<AccountPageViewmodel>(
        viewModel: AccountPageViewmodel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onPageBuilder: (BuildContext context, AccountPageViewmodel viewmodel) {
          return Observer(builder: (context) {
            return viewmodel.isChangeLangLoading
                ? const CircularProgressIndicator()
                : Scaffold(
                    appBar: AppBar(
                      title: Text(
                        LocaleKeys
                            .account_page_my_account_settings_language_languages
                            .locale,
                      ),
                    ),
                    body: ListView.builder(
                      itemCount: myLangList.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () async {
                            alertDialog(context, myLangList[index], viewmodel);
                          },
                          child: Container(
                            color: ColorSchemeLight.instance!.background,
                            alignment: Alignment.centerLeft,
                            padding: context.paddingLow,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: context.paddingLow.vertical / 2,
                                  horizontal:
                                      context.paddingLow.horizontal / 2),
                              child: Text(
                                myLangList[index].name,
                                style: context.textTheme.bodyMedium!
                                    .copyWith(color: Colors.blue),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
          });
        });
  }
}

alertDialog(BuildContext context, LanguageModel languageModel,
    AccountPageViewmodel viewmodel) {
  return showDialog(
      context: context,
      builder: (_) {
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text(languageModel.name),
                content: Text(LocaleKeys
                    .account_page_my_account_settings_language_are_you_sure
                    .locale),
                actions: <Widget>[
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text(
                      LocaleKeys
                          .account_page_my_account_settings_language_no.locale,
                      style: context.textTheme.labelLarge!.copyWith(
                        color: CupertinoColors.systemRed,
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
                          .account_page_my_account_settings_language_yes.locale,
                      style: context.textTheme.labelLarge!.copyWith(
                        color: CupertinoColors.activeBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context, rootNavigator: true).pop();
                      await Future.delayed(const Duration(milliseconds: 500))
                          .then((value) async {
                        await context
                            .setLocale(
                          Locale(languageModel.langCode),
                        )
                            .then((value) async {
                          Navigator.pushNamedAndRemoveUntil(context,
                              NavigationConstants.DEFAULT, (route) => false);
                        });
                      });
                    },
                  ),
                ],
              )
            : AlertDialog(
                title: Text(languageModel.name),
                content: Text(LocaleKeys
                    .account_page_my_account_settings_language_are_you_sure
                    .locale),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      LocaleKeys
                          .account_page_my_account_settings_language_no.locale,
                      style: context.textTheme.labelLarge!.copyWith(
                        color: CupertinoColors.systemRed,
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
                          .account_page_my_account_settings_language_yes.locale,
                      style: context.textTheme.labelLarge!.copyWith(
                        color: CupertinoColors.activeBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context, rootNavigator: true).pop();
                      await Future.delayed(const Duration(milliseconds: 500))
                          .then((value) async {
                        await context
                            .setLocale(
                          Locale(languageModel.langCode),
                        )
                            .then((value) async {
                          Navigator.pushNamedAndRemoveUntil(context,
                              NavigationConstants.DEFAULT, (route) => false);
                        });
                      });
                    },
                  ),
                ],
              );
      });
}
