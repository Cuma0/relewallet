import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../core/constants/enums/locale_keys_enum.dart';
import '../../../core/init/cache/locale_manager.dart';
import '../../cardsPage/provider/my_card_provider.dart';
import '../model/language_model/language_model.dart';
import '../model/sign_in_response_model/sign_in_response_model.dart';
import '../model/sign_in_with_apple_model/sign_in_with_apple_model.dart';
import '../model/sign_in_with_google_model/sign_in_with_google_model.dart';
import '../model/sign_up_with_mail_model/sign_up_with_mail_model.dart';
import '../provider/account_provider.dart';
import '../services/IAccountpageService.dart';
import '../services/accountpage_service.dart';

part 'account_page_viewmodel.g.dart';

class AccountPageViewmodel = AccountPageViewmodelBase
    with _$AccountPageViewmodel;

abstract class AccountPageViewmodelBase with Store, BaseViewModel {
  late IAccountpageService accountpageService;
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();
  PageController? pageController;
  int currentScreen = 2;
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  late TextEditingController signUpMailController;
  late TextEditingController signUpPasswordController;
  late TextEditingController signUpPasswordAgainController;
  late TextEditingController signInMailController;
  late TextEditingController signInPasswordController;

  void setContext(BuildContext context) => myContext = context;

  void init() {
    pageController = PageController(
        initialPage: localeManager.getStringValue(PreferencesKeys.TOKEN).isEmpty
            ? 2
            : 3);
    accountpageService =
        AccountpageService(vexanaManager!.networkManager, scaffoldMessengerKey);
    signUpMailController = TextEditingController();
    signUpPasswordController = TextEditingController();
    signUpPasswordAgainController = TextEditingController();
    signInMailController = TextEditingController();
    signInPasswordController = TextEditingController();
  }

  @observable
  bool isChangeLangLoading = false;

  @action
  void isChangeLangLoadingChange() {
    isChangeLangLoading = !isChangeLangLoading;
  }

  Future<bool> changeLang({
    required BuildContext context,
    required LanguageModel languageModel,
  }) async {
    isChangeLangLoadingChange();

    await context.setLocale(
      Locale(languageModel.langCode),
    );
    await LocaleManager.instance
        .setStringValue(PreferencesKeys.LANG, languageModel.langCode);

    isChangeLangLoadingChange();

    return Future.delayed(const Duration(milliseconds: 750))
        .then((value) => true);
  }

  @observable
  bool isLoadinSignInWithMail = false;

  @action
  void changeSignInWithMailChange() {
    isLoadinSignInWithMail = !isLoadinSignInWithMail;
  }

  @observable
  bool isIncorrectUser = false;

  @action
  void changeisIncorrectUser() {
    isIncorrectUser = !isIncorrectUser;
  }

  Future<void> signInWithMail(SignUpWithMailModel signUpWithMailModel) async {
    signUpWithMailModel.isPassword = true;
    changeSignInWithMailChange();
    SignInResponseModel? response =
        await accountpageService.signInWithMail(signUpWithMailModel);
    if (response != null && response.id == "incorrect") {
      changeisIncorrectUser();
      changeSignInWithMailChange();
    } else if (response != null) {
      await LocaleManager.instance
          .setBoolValue(PreferencesKeys.SIGN_IN_APPLE, false);
      await LocaleManager.instance
          .setBoolValue(PreferencesKeys.SIGN_IN_GOOGLE, false);
      final AccountProvider accountProvider =
          Provider.of<AccountProvider>(myContext!, listen: false);
      await localeManager.setStringValue(
          PreferencesKeys.TOKEN, response.token!);

      await localeManager.setStringValue(
          PreferencesKeys.NAME, signUpWithMailModel.email);
      await localeManager.setStringValue(
          PreferencesKeys.EMAIL, signUpWithMailModel.email);
      accountProvider.setUserName(signUpWithMailModel.email);
      await localeManager.setStringValue(PreferencesKeys.PHOTO_URL, null);
      accountProvider.setProfilePic(null);
      await localeManager.setStringValue(PreferencesKeys.FCM_TOKEN, "1");
      await localeManager.setStringValue(PreferencesKeys.FCM_TOPIC, "1");

      final myCardProvider =
          Provider.of<MyCardProvider>(myContext!, listen: false);
      myCardProvider.setMyCardList(response.myCards);
      changeSignInWithMailChange();

      await pageController!
          .animateToPage(3,
              duration: const Duration(milliseconds: 500), curve: Curves.ease)
          .then(
            (value) async {},
          );
    } else {
      changeSignInWithMailChange();
    }
  }

  @observable
  bool isLoadinSignUpWithMail = false;

  @action
  void isLoadingSignUpWithMailChange() {
    isLoadinSignUpWithMail = !isLoadinSignUpWithMail;
  }

  @observable
  bool isMailExists = false;

  @action
  void changeisMailExists(bool newMailExists) {
    isMailExists = newMailExists;
  }

  @observable
  bool isPasswordsNotMatch = false;

  @action
  void changeisPasswordsNotMatch(bool newisPasswordsNotMatch) {
    isPasswordsNotMatch = newisPasswordsNotMatch;
  }

  @observable
  bool isPasswordVisible = false;

  @action
  void changeisPasswordVisible() {
    isPasswordVisible = !isPasswordVisible;
  }

  Future<void> signUpWithMail(SignUpWithMailModel signUpWithMailModel) async {
    signUpWithMailModel.isPassword = true;
    isLoadingSignUpWithMailChange();
    SignInResponseModel? response =
        await accountpageService.signUpWithMail(signUpWithMailModel);
    if (response != null && response.id == "already exists") {
      changeisMailExists(true);
      isLoadingSignUpWithMailChange();
    } else if (response != null) {
      await LocaleManager.instance
          .setBoolValue(PreferencesKeys.SIGN_IN_APPLE, false);
      await LocaleManager.instance
          .setBoolValue(PreferencesKeys.SIGN_IN_GOOGLE, false);
      final AccountProvider accountProvider =
          Provider.of<AccountProvider>(myContext!, listen: false);
      await localeManager.setStringValue(
          PreferencesKeys.TOKEN, response.token!);

      await localeManager.setStringValue(
          PreferencesKeys.NAME, signUpWithMailModel.email);
      await localeManager.setStringValue(
          PreferencesKeys.EMAIL, signUpWithMailModel.email);
      accountProvider.setUserName(signUpWithMailModel.email);
      await localeManager.setStringValue(PreferencesKeys.PHOTO_URL, null);
      accountProvider.setProfilePic(null);
      await localeManager.setStringValue(PreferencesKeys.FCM_TOKEN, "1");
      await localeManager.setStringValue(PreferencesKeys.FCM_TOPIC, "1");

      final myCardProvider =
          Provider.of<MyCardProvider>(myContext!, listen: false);
      myCardProvider.setMyCardList(response.myCards);
      isLoadingSignUpWithMailChange();
      await pageController!
          .animateToPage(3,
              duration: const Duration(milliseconds: 500), curve: Curves.ease)
          .then(
            (value) async {},
          );
    } else {
      isLoadingSignUpWithMailChange();
    }
  }

  @observable
  bool isLoadingDeleteUser = false;

  @action
  void changeLoadingDeleteUser() {
    isLoadingDeleteUser = !isLoadingDeleteUser;
  }

  @action
  Future<bool> deleteAccount() async {
    changeLoadingDeleteUser();
    final response = await accountpageService.deleteUser();
    if (response == true) {
      changeLoadingDeleteUser();
      await LocaleManager.instance.clearAllSaveFirst();

      final myCardProvider =
          Provider.of<MyCardProvider>(myContext!, listen: false);
      myCardProvider.setMyCardList([]);
      return true;
    } else {
      changeLoadingDeleteUser();
      return false;
    }
  }

  Future<void> googleAuth() async {
    GoogleSignInAccount? gUser;
    try {
      gUser = Platform.isIOS
          ? await GoogleSignIn(
                  // Optional clientId
                  clientId:
                      '1085029130268-pc53k7v4fkdo96kt75vch6dhfeobrojg.apps.googleusercontent.com')
              .signIn()
          : await GoogleSignIn(
              clientId:
                  '1085029130268-lpkrtgdnl8leqd9ar2nod8ep4pt150v0.apps.googleusercontent.com',
              scopes: [
                'https://www.googleapis.com/auth/userinfo.email',
                'openid',
                'https://www.googleapis.com/auth/userinfo.profile',
              ],
            ).signIn();
    } catch (error) {
      scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        content: Text(
          error.toString(),
          style: const TextStyle(color: Colors.black),
        ),
      ));
    }
//PlatformException(sign_in_failed, l1.b: 10: , null, null)
    if (gUser != null) {
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      signInWithGoogle(
        gUser: gUser,
        signInRequestModel: SignInWithGoogleModel(
          idToken: gAuth.idToken,
          email: gUser.email,
        ),
      );
    } else {
    }
  }

  @observable
  bool isLoadinSignInWithGoogle = false;

  @action
  void isLoadingSignInWithGoogleChange() {
    isLoadinSignInWithGoogle = !isLoadinSignInWithGoogle;
  }

  Future<void> signInWithGoogle(
      {required GoogleSignInAccount gUser,
      required SignInWithGoogleModel signInRequestModel}) async {
    signInRequestModel.isPassword = false;
    signInRequestModel.fcmToken =
        LocaleManager.instance.getStringValue(PreferencesKeys.FCM_TOKEN);
    isLoadingSignInWithGoogleChange();
    SignInResponseModel? response =
        await accountpageService.signInWithGoogle(signInRequestModel);
    if (response != null) {
      await LocaleManager.instance
          .setBoolValue(PreferencesKeys.SIGN_IN_APPLE, false);
      await LocaleManager.instance
          .setBoolValue(PreferencesKeys.SIGN_IN_GOOGLE, true);
      final AccountProvider accountProvider =
          Provider.of<AccountProvider>(myContext!, listen: false);
      await localeManager.setStringValue(
          PreferencesKeys.TOKEN, response.token!);

      await localeManager.setStringValue(
          PreferencesKeys.NAME, gUser.displayName);
      await localeManager.setStringValue(PreferencesKeys.EMAIL, gUser.email);
      accountProvider.setUserName(gUser.displayName);
      await localeManager.setStringValue(
          PreferencesKeys.PHOTO_URL, gUser.photoUrl);
      accountProvider.setProfilePic(gUser.photoUrl);
      await localeManager.setStringValue(PreferencesKeys.FCM_TOKEN, "1");
      await localeManager.setStringValue(PreferencesKeys.FCM_TOPIC, "1");
      await localeManager.setBoolValue(PreferencesKeys.SIGN_IN_GOOGLE, true);
      final myCardProvider =
          Provider.of<MyCardProvider>(myContext!, listen: false);
      myCardProvider.setMyCardList(response.myCards);
      isLoadingSignInWithGoogleChange();
      await pageController!
          .animateToPage(3,
              duration: const Duration(milliseconds: 500), curve: Curves.ease)
          .then(
            (value) async {},
          );
    } else {
      isLoadingSignInWithGoogleChange();
    }
  }

  @observable
  bool isLoadingSignInWithApple = false;

  @action
  void changeLoadingSignInWithApple() {
    isLoadingSignInWithApple = !isLoadingSignInWithApple;
  }

  Future<void> appleAuth() async {
    try {
      final AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'com.relewalletapp.relewallet-service',
          redirectUri: Uri.parse('https://relewallet.com/user/signin/apple'),
        ),
      );
      signInWithApple(
          signInWithAppleModel: SignInWithAppleModel(
              authorizationCode: credential.authorizationCode,
              identityToken: credential.identityToken));
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> signInWithApple(
      {required SignInWithAppleModel signInWithAppleModel}) async {
    signInWithAppleModel.fcmToken =
        LocaleManager.instance.getStringValue(PreferencesKeys.FCM_TOKEN);
    SignInResponseModel? response =
        await accountpageService.signInWithApple(signInWithAppleModel);
    if (response != null && response.id == "incorrect") {
      changeisIncorrectUser();
    } else if (response != null) {
      await LocaleManager.instance
          .setBoolValue(PreferencesKeys.SIGN_IN_APPLE, true);
      await LocaleManager.instance
          .setBoolValue(PreferencesKeys.SIGN_IN_GOOGLE, false);
      final AccountProvider accountProvider =
          Provider.of<AccountProvider>(myContext!, listen: false);
      await localeManager.setStringValue(
          PreferencesKeys.TOKEN, response.token!);

      await localeManager.setStringValue(PreferencesKeys.NAME, null);
      accountProvider.setUserName(null);
      await localeManager.setStringValue(PreferencesKeys.EMAIL, response.email);
      accountProvider.setEmail(response.email);
      await localeManager.setStringValue(PreferencesKeys.PHOTO_URL, null);
      accountProvider.setProfilePic(null);
      await localeManager.setStringValue(PreferencesKeys.FCM_TOKEN, "1");
      await localeManager.setStringValue(PreferencesKeys.FCM_TOPIC, "1");
      final myCardProvider =
          Provider.of<MyCardProvider>(myContext!, listen: false);
      myCardProvider.setMyCardList(response.myCards);
      await pageController!
          .animateToPage(3,
              duration: const Duration(milliseconds: 500), curve: Curves.ease)
          .then(
            (value) async {},
          );
    }
  }
}
