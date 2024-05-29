import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/light/color_scheme_light.dart';
import '../model/sign_up_with_mail_model/sign_up_with_mail_model.dart';
import '../../cardsPage/provider/my_card_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/base/view/base_widget.dart';
import '../../../core/components/buttons/button_with_pic/button_with_pic.dart';
import '../../../core/constants/app/app_constants.dart';
import '../../../core/constants/enums/locale_keys_enum.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/extension/string_extension.dart';
import '../../../core/init/cache/locale_manager.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../../../core/theme/light/text_theme_light.dart';
import '../../_widgets/circle_avatar/profile_photo_widget.dart';
import '../../_widgets/settings_widget/settings_widget.dart';
import '../provider/account_provider.dart';
import '../viewmodel/account_page_viewmodel.dart';

class AccountPageView extends StatefulWidget {
  const AccountPageView({super.key});

  @override
  State<AccountPageView> createState() => _AccountPageViewState();
}

class _AccountPageViewState extends State<AccountPageView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<AccountPageViewmodel>(
      viewModel: AccountPageViewmodel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, AccountPageViewmodel viewmodel) {
        return ScaffoldMessenger(
          key: viewmodel.scaffoldMessengerKey,
          child: Scaffold(
            appBar: AppBar(
              title: Text(LocaleManager.instance
                      .getStringValue(PreferencesKeys.TOKEN)
                      .isEmpty
                  ? LocaleKeys.account_page_account.locale
                  : LocaleKeys.account_page_my_account_my_account.locale),
            ),
            body: PageView(
              controller: viewmodel.pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                viewmodel.currentScreen = value;
              },
              children: [
                signinWithMailPage(context: context, viewmodel: viewmodel),
                signUpWithMailPage(context: context, viewmodel: viewmodel),
                signUpWithGooglePage(context: context, viewmodel: viewmodel),
                myAccountPage(context: context, viewmodel: viewmodel),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget myAccountPage(
      {required BuildContext context,
      required AccountPageViewmodel viewmodel}) {
    final AccountProvider accountProvider = context.watch<AccountProvider>();
    return SingleChildScrollView(
      child: Padding(
        padding: context.paddingNormalHorizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.normalSizedBoxVertical,
            Row(
              children: [
                profilePhotoWidget(context, accountProvider.getUserProfilePic),
                context.normalSizedBoxHorizontal,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleManager.instance.getBoolValue(
                                  PreferencesKeys.SIGN_IN_APPLE) ==
                              true
                          ? accountProvider.getEmail!
                          : accountProvider.getUserName!,
                      style: TextThemeLight.instance!.titleLarge,
                    ),
                    context.lowSizedBoxVertical,
                    Text(
                      LocaleManager.instance.getBoolValue(
                                  PreferencesKeys.SIGN_IN_APPLE) ==
                              true
                          ? LocaleKeys
                              .account_page_my_account_login_apple.locale
                          : LocaleKeys
                              .account_page_my_account_login_google.locale,
                      style: TextThemeLight.instance!.titleSmall.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    context.lowSizedBoxVertical,
                    LocaleManager.instance
                                .getBoolValue(PreferencesKeys.SIGN_IN_APPLE) ==
                            true
                        ? const SizedBox()
                        : InkWell(
                            onTap: () {
                              _urlLauncher(
                                  url: "https://myaccount.google.com/");
                            },
                            child: Text(
                              LocaleKeys.account_page_my_account_manage_account
                                  .locale,
                              style:
                                  TextThemeLight.instance!.titleSmall.copyWith(
                                fontWeight: FontWeight.w500,
                                color: CupertinoColors.activeBlue,
                              ),
                            ),
                          ),
                  ],
                )
              ],
            ),
            context.highSizedBoxVertical,
            context.highSizedBoxVertical,
            settingsWidget(
              context: context,
              settingsModel: SettingsModel(
                title: LocaleKeys.account_page_share_share.locale,
                settingsItems: [
                  SettingsItems(
                    settingTitle:
                        LocaleKeys.account_page_share_share_with_friends.locale,
                    pic: "assets/images/share.png",
                    onPressed: () {
                      shareApp();
                    },
                  ),
                ],
              ),
            ),
            context.highSizedBoxVertical,
            settingsWidget(
              context: context,
              settingsModel: SettingsModel(
                title:
                    LocaleKeys.account_page_my_account_settings_settings.locale,
                settingsItems: [
                  SettingsItems(
                    settingTitle: LocaleKeys
                        .account_page_my_account_settings_card_assistant.locale,
                    pic: "assets/images/assistant.png",
                    onPressed: () async {
                      await Navigator.of(context, rootNavigator: true)
                          .pushNamed(NavigationConstants.CARD_ASISSTANT_VIEW,
                              arguments: viewmodel);
                    },
                  ),
                  SettingsItems(
                    settingTitle: LocaleKeys
                        .account_page_my_account_settings_language_languages
                        .locale,
                    pic: "assets/images/regions.png",
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed(NavigationConstants.LANG_CHANGE_PAGE_VIEW);
                    },
                  ),
                  SettingsItems(
                    settingTitle: LocaleKeys
                        .account_page_my_account_settings_advanced_settings
                        .locale,
                    pic: "assets/images/settings.png",
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pushNamed(
                        NavigationConstants.ADVANCED_SETTINGS_PAGE_VIEW,
                        arguments: context.read<MyCardProvider>().getMyCardList,
                      );
                    },
                  ),
                ],
              ),
            ),
            context.highSizedBoxVertical,
            settingsWidget(
              context: context,
              settingsModel: SettingsModel(
                title:
                    LocaleKeys.account_page_my_account_support_support.locale,
                settingsItems: [
                  SettingsItems(
                    settingTitle:
                        LocaleKeys.account_page_my_account_support_help.locale,
                    pic: "assets/images/help.png",
                    onPressed: () {
                      _urlLauncher(url: AppConstants.APP_WEB_SITE);
                    },
                  ),
                  SettingsItems(
                    settingTitle: LocaleKeys
                        .account_page_my_account_support_support.locale,
                    pic: "assets/images/support.png",
                    onPressed: () {
                      emailLauncher(email: "support@relewallet.com");
                    },
                  ),
                ],
              ),
            ),
            context.lowSizedBoxVertical,
          ],
        ),
      ),
    );
  }
}

Widget signUpWithMailPage(
    {required BuildContext context, required AccountPageViewmodel viewmodel}) {
  return SingleChildScrollView(
    child: Padding(
      padding: context.paddingNormalHorizontal,
      child: Column(
        children: [
          context.normalSizedBoxVertical,
          Text(
            LocaleKeys.account_page_sign_up_with_email_page_sign_up.locale,
            style: TextThemeLight.instance!.bodyLarge.copyWith(fontSize: 24),
          ),
          context.normalSizedBoxVertical,
          Form(
            key: viewmodel.signUpFormKey,
            child: Column(
              children: [
                context.lowSizedBoxVertical,
                SizedBox(
                  height: context.mediumValue * 2.2,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: viewmodel.signUpMailController,
                    decoration: InputDecoration(
                      labelText: LocaleKeys
                          .account_page_sign_up_with_email_page_email.locale,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      return value!.isEmpty
                          ? LocaleKeys
                              .account_page_sign_up_with_email_page_email_required
                              .locale
                          : value.isValidEmails
                              ? null
                              : LocaleKeys
                                  .account_page_sign_up_with_email_page_enter_valid_email
                                  .locale;
                    },
                  ),
                ),
                context.lowSizedBoxVertical,
                SizedBox(
                  height: context.mediumValue * 2.2,
                  child: Observer(builder: (_) {
                    return TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: viewmodel.signUpPasswordController,
                      obscureText: viewmodel.isPasswordVisible ? false : true,
                      decoration: InputDecoration(
                        labelText: LocaleKeys
                            .account_page_sign_up_with_email_page_password
                            .locale,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(),
                        ),
                      ),
                      validator: (value) {
                        return value!.isEmpty
                            ? LocaleKeys
                                .account_page_sign_up_with_email_page_password_required
                                .locale
                            : value.length < 6
                                ? LocaleKeys
                                    .account_page_sign_up_with_email_page_at_least_6_characters
                                    .locale
                                : null;
                      },
                    );
                  }),
                ),
                context.lowSizedBoxVertical,
                SizedBox(
                  height: context.mediumValue * 2.2,
                  child: Observer(builder: (_) {
                    return TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: viewmodel.signUpPasswordAgainController,
                      obscureText: viewmodel.isPasswordVisible ? false : true,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            viewmodel.changeisPasswordVisible();
                          },
                          icon: Icon(
                            viewmodel.isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        labelText: LocaleKeys
                            .account_page_sign_up_with_email_page_password_again
                            .locale,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(),
                        ),
                      ),
                      validator: (value) {
                        return value!.isEmpty
                            ? LocaleKeys
                                .account_page_sign_up_with_email_page_password_required
                                .locale
                            : value.length < 6
                                ? LocaleKeys
                                    .account_page_sign_up_with_email_page_at_least_6_characters
                                    .locale
                                : null;
                      },
                    );
                  }),
                ),
                context.lowSizedBoxVertical,
              ],
            ),
          ),
          Observer(builder: (_) {
            return viewmodel.isMailExists
                ? Column(
                    children: [
                      Text(
                        LocaleKeys
                            .account_page_sign_up_with_email_page_email_exists
                            .locale,
                      ),
                      context.normalSizedBoxVertical,
                    ],
                  )
                : viewmodel.isPasswordsNotMatch
                    ? Column(
                        children: [
                          Text(
                            LocaleKeys
                                .account_page_sign_up_with_email_page_password_not_match
                                .locale,
                          ),
                          context.normalSizedBoxVertical,
                        ],
                      )
                    : const SizedBox();
          }),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorSchemeLight.instance!.blue,
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              fixedSize: Size(
                double.maxFinite,
                context.mediumValue * 1.42,
              ),
            ),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (viewmodel.signUpFormKey.currentState!.validate()) {
                if (viewmodel.signUpPasswordController.text !=
                    viewmodel.signUpPasswordAgainController.text) {
                  viewmodel.changeisPasswordsNotMatch(true);
                } else {
                  viewmodel.changeisPasswordsNotMatch(false);
                  viewmodel.signUpWithMail(
                    SignUpWithMailModel(
                        isPassword: true,
                        email: viewmodel.signUpMailController.text,
                        password: viewmodel.signUpPasswordController.text,
                        fcmToken: LocaleManager.instance
                            .getStringValue(PreferencesKeys.FCM_TOKEN)),
                  );
                }
              }
            },
            child: Observer(
              builder: (_) {
                return viewmodel.isLoadinSignUpWithMail
                    ? SizedBox(
                        height: context.mediumValue / 2,
                        width: context.mediumValue / 2,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                          strokeAlign: 1,
                        ),
                      )
                    : Text(
                        LocaleKeys.account_page_sign_up_with_email_page_sign_up
                            .locale,
                        style: TextThemeLight.instance!.button.copyWith(
                          color: Colors.white,
                        ),
                      );
              },
            ),
          ),
          context.lowSizedBoxVertical,
          TextButton(
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              await viewmodel.pageController!
                  .animateToPage(2,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease)
                  .then(
                    (value) async {},
                  );
            },
            child: Text(
              LocaleKeys
                  .account_page_sign_up_with_email_page_already_have_account
                  .locale,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget signinWithMailPage(
    {required BuildContext context, required AccountPageViewmodel viewmodel}) {
  return SingleChildScrollView(
    child: Padding(
      padding: context.paddingNormalHorizontal,
      child: Column(
        children: [
          context.normalSizedBoxVertical,
          Text(
            LocaleKeys.account_page_sign_in_with_email_page_sign_in.locale,
            style: TextThemeLight.instance!.bodyLarge.copyWith(fontSize: 24),
          ),
          context.normalSizedBoxVertical,
          Form(
            key: viewmodel.signInFormKey,
            child: Column(
              children: [
                context.lowSizedBoxVertical,
                SizedBox(
                  height: context.mediumValue * 2.2,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: viewmodel.signInMailController,
                    decoration: InputDecoration(
                      labelText: LocaleKeys
                          .account_page_sign_up_with_email_page_email.locale,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      return value!.isEmpty
                          ? LocaleKeys
                              .account_page_sign_up_with_email_page_email_required
                              .locale
                          : value.isValidEmails
                              ? null
                              : LocaleKeys
                                  .account_page_sign_up_with_email_page_enter_valid_email
                                  .locale;
                    },
                  ),
                ),
                context.lowSizedBoxVertical,
                SizedBox(
                  height: context.mediumValue * 2.2,
                  child: Observer(builder: (_) {
                    return TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: viewmodel.signInPasswordController,
                      obscureText: viewmodel.isPasswordVisible ? false : true,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            viewmodel.changeisPasswordVisible();
                          },
                          icon: Icon(
                            viewmodel.isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        labelText: LocaleKeys
                            .account_page_sign_up_with_email_page_password
                            .locale,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(),
                        ),
                      ),
                      validator: (value) {
                        return value!.isEmpty
                            ? LocaleKeys
                                .account_page_sign_up_with_email_page_password_required
                                .locale
                            : null;
                      },
                    );
                  }),
                ),
                context.lowSizedBoxVertical,
              ],
            ),
          ),
          Observer(builder: (_) {
            return viewmodel.isIncorrectUser
                ? Column(
                    children: [
                      Text(
                        LocaleKeys
                            .account_page_sign_in_with_email_page_incorrect_email_or_password
                            .locale,
                      ),
                      context.normalSizedBoxVertical,
                    ],
                  )
                : const SizedBox();
          }),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorSchemeLight.instance!.blue,
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              fixedSize: Size(
                double.maxFinite,
                context.mediumValue * 1.42,
              ),
            ),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (viewmodel.signInFormKey.currentState!.validate()) {
                viewmodel.signInWithMail(
                  SignUpWithMailModel(
                    isPassword: true,
                    email: viewmodel.signInMailController.text,
                    password: viewmodel.signInPasswordController.text,
                    fcmToken: LocaleManager.instance
                        .getStringValue(PreferencesKeys.FCM_TOKEN),
                  ),
                );
              }
            },
            child: Observer(
              builder: (_) {
                return viewmodel.isLoadinSignInWithMail
                    ? SizedBox(
                        height: context.mediumValue / 2,
                        width: context.mediumValue / 2,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                          strokeAlign: 1,
                        ),
                      )
                    : Text(
                        LocaleKeys.account_page_sign_in_with_email_page_sign_in
                            .locale,
                        style: TextThemeLight.instance!.button.copyWith(
                          color: Colors.white,
                        ),
                      );
              },
            ),
          ),
          context.lowSizedBoxVertical,
          TextButton(
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              await viewmodel.pageController!
                  .animateToPage(2,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease)
                  .then(
                    (value) async {},
                  );
            },
            child: Text(
              LocaleKeys.account_page_sign_in_with_email_page_no_account_signup
                  .locale,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget signUpWithGooglePage({
  required BuildContext context,
  required AccountPageViewmodel viewmodel,
}) {
  return Padding(
    padding: context.paddingNormalHorizontal,
    child: ListView(
      children: [
        context.normalSizedBoxVertical,
        profilePhotoWidget(context, null),
        context.highSizedBoxVertical,
        Align(
          alignment: Alignment.center,
          child: Text(
            LocaleKeys.account_page_sign_up_page_no_account.locale,
            style: TextThemeLight.instance!.bodyLarge,
          ),
        ),
        context.normalSizedBoxVertical,
        Align(
          alignment: Alignment.center,
          child: Text(
            LocaleKeys.account_page_sign_up_page_never_lose_cards.locale,
            style: TextThemeLight.instance!.bodyLarge
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        context.highSizedBoxVertical,
        context.highSizedBoxVertical,

       Platform.isIOS ? SizedBox(
          height: context.mediumValue * 1.5,
          child: buttonWithPic(
            image: "assets/images/google.png",
            context: context,
            onPressed: () {
              viewmodel.googleAuth();
            },
          ),
        ): const SizedBox(),
        context.normalSizedBoxVertical,
        Platform.isIOS
            ? Observer(builder: (_) {
                return viewmodel.isLoadingSignInWithApple
                    ? SizedBox(
                        height: context.mediumValue * 1.5,
                        width: context.mediumValue * 1.5,
                        child: const Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 3,
                        )),
                      )
                    : SizedBox(
                        height: context.mediumValue * 1.5,
                        child: buttonWithPic(
                          image: "assets/images/apple.png",
                          text: LocaleKeys
                              .account_page_sign_up_page_sign_in_apple.locale,
                          context: context,
                          onPressed: () {
                            viewmodel.appleAuth();
                          },
                        ),
                      );
              })
            : const SizedBox(),

        // SizedBox(
        //     height: context.mediumValue * 1.5,
        //     child: ElevatedButton(
        //       onPressed: () async {
        //         viewmodel.googleAuth();
        //       },
        //       child: Text(
        //           LocaleKeys.account_page_sign_up_page_log_in.locale,
        //           style: TextThemeLight.instance!.buttonSmall),
        //     ),
        //   ),
        context.normalSizedBoxVertical,
        SizedBox(
          height: context.mediumValue * 1.5,
          child: buttonWithPic(
            icon: Icons.mail,
            context: context,
            text: LocaleKeys
                .account_page_sign_up_with_email_page_sign_up_with_email.locale,
            onPressed: () async {
              await viewmodel.pageController!
                  .animateToPage(1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease)
                  .then(
                    (value) async {},
                  );
            },
          ),
        ),
        context.normalSizedBoxVertical,
        Align(
          alignment: Alignment.center,
          child: Text(
            LocaleKeys.account_page_sign_up_page_have_account.locale,
            style: TextThemeLight.instance!.bodySmall.copyWith(fontSize: 14),
          ),
        ),
        TextButton(
          onPressed: () async {
            await viewmodel.pageController!
                .animateToPage(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease)
                .then(
                  (value) async {},
                );
          },
          child: Text(
            LocaleKeys.account_page_sign_in_with_email_page_sign_in.locale,
            style: TextThemeLight.instance!.button.copyWith(
              color: ColorSchemeLight.instance!.blue,
            ),
          ),
        ),
        context.highSizedBoxVertical,
        settingsWidget(
          context: context,
          settingsModel: SettingsModel(
            title: LocaleKeys.account_page_share_share.locale,
            settingsItems: [
              SettingsItems(
                settingTitle:
                    LocaleKeys.account_page_share_share_with_friends.locale,
                pic: "assets/images/share.png",
                onPressed: () {
                  shareApp();
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

void shareApp() {
  Share.share(
    "${LocaleKeys.settings_page_share_text.locale} ${AppConstants.APP_WEB_SITE}",
  );
}

void emailLauncher({required String email}) async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email,
  );
  launchUrl(emailLaunchUri);
}

Future<void> _urlLauncher({required String url}) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}
