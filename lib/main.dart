import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app/app_constants.dart';
import 'core/constants/enums/locale_keys_enum.dart';
import 'core/init/cache/locale_manager.dart';
import 'core/init/lang/language_manager.dart';
import 'core/init/navigation/navigation_provider.dart';
import 'core/init/navigation/navigation_service.dart';
import 'core/init/notifier/provider_list.dart';
import 'core/init/notifier/theme_notifier.dart';

Future<void> main() async {
  await _init();
  runApp(
    MultiProvider(
      providers: [...ApplicationProvider.instance.dependItems],
      child: EasyLocalization(
        supportedLocales: LanguageManager.instance.supportedLocales,
        fallbackLocale: LanguageManager.instance.enLocale,
        useOnlyLangCode: true,
        path: AppConstants.ASSETS_LANG_PATH,
        child: const MyApp(),
      ),
    ),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: 'AIzaSyBKb5rrJzOGS5Bwt8ajp3i9vPecP21pHZ4',
            appId: '1:1085029130268:android:72c932676fddef93987fd9',
            messagingSenderId: '1085029130268',
            projectId: 'relewallet',
          ),
        )
      : await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await LocaleManager.prefrencesInit();
  await FirebaseMessaging.instance.requestPermission();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  String? apnsToken;

  String? token;
  if (LocaleManager.instance.getBoolValue(PreferencesKeys.IS_FIRST_APP) ==
      false) {
    await LocaleManager.instance
        .setBoolValue(PreferencesKeys.NOTIFICATIONS, true);

    await LocaleManager.instance
        .setBoolValue(PreferencesKeys.LOCALE_AUTH, false);

    await LocaleManager.instance
        .setBoolValue(PreferencesKeys.IS_FIRST_APP, true);

    if (Platform.isIOS) {
      apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {
        token = await FirebaseMessaging.instance.getToken();
        await FirebaseMessaging.instance.subscribeToTopic("en");
        await LocaleManager.instance
            .setStringValue(PreferencesKeys.FCM_APNSTOKEN, apnsToken);
        await LocaleManager.instance
            .setStringValue(PreferencesKeys.FCM_TOKEN, token ?? "null");
      } else {
        await Future.delayed(const Duration(seconds: 5)).then((value) async {
          apnsToken = await FirebaseMessaging.instance.getAPNSToken();
          token = await FirebaseMessaging.instance.getToken();
          await FirebaseMessaging.instance.subscribeToTopic("en");
          await LocaleManager.instance
              .setStringValue(PreferencesKeys.FCM_APNSTOKEN, apnsToken);
          await LocaleManager.instance
              .setStringValue(PreferencesKeys.FCM_TOKEN, token ?? "null");
        });
      }
    } else {
      token = await FirebaseMessaging.instance.getToken();
      await LocaleManager.instance
          .setStringValue(PreferencesKeys.FCM_TOKEN, token ?? "null");
      await FirebaseMessaging.instance.subscribeToTopic("en");
    }
  }

  // onMessage: When the app is open and it receives a push notification
  FirebaseMessaging.onMessage.listen((event) {
  });
  // replacement for onResume: When the app is in the background and opened directly from the push notification.
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    if (event.data["data"] != null && event.data["data"] != "") {
     // Map<String, dynamic> eventMap = json.decode(event.data["data"]);
    }
  });

  // workaround for onLaunch: When the app is completely closed
  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage? remoteMessage) {
    if (remoteMessage != null &&
        remoteMessage.data["data"] != null &&
        remoteMessage.data["data"] != "") {
      //Map<String, dynamic> eventMap = json.decode(remoteMessage.data["data"]);
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relewallet',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: NavigationProvider.of(context).onGenerateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: context.watch<ThemeNotifier>().currentTheme,
    );
  }
}
