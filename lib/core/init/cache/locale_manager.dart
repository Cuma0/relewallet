import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/enums/locale_keys_enum.dart';

class LocaleManager {
  static final LocaleManager _instance = LocaleManager._init();

  SharedPreferences? _preferences;
  static LocaleManager get instance => _instance;

  LocaleManager._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }
  static Future prefrencesInit() async {
    instance._preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> clearAll() async {
    await _preferences!.clear();
  }

  Future<void> clearAllSaveFirst() async {
    if (_preferences != null) {
      String? fcmToken =
          LocaleManager.instance.getStringValue(PreferencesKeys.FCM_TOKEN);
      String? apnsToken =
          LocaleManager.instance.getStringValue(PreferencesKeys.FCM_APNSTOKEN);

      await _preferences!.clear();
      await setBoolValue(PreferencesKeys.IS_FIRST_APP, true);

      await LocaleManager.instance
          .setBoolValue(PreferencesKeys.LOCALE_AUTH, false);
      await LocaleManager.instance
          .setBoolValue(PreferencesKeys.NOTIFICATIONS, true);
      await LocaleManager.instance
          .setStringValue(PreferencesKeys.FCM_TOKEN, fcmToken);
      await LocaleManager.instance
          .setStringValue(PreferencesKeys.FCM_APNSTOKEN, apnsToken);
      await LocaleManager.instance
          .setBoolValue(PreferencesKeys.SIGN_IN_APPLE, false);
      await LocaleManager.instance
          .setBoolValue(PreferencesKeys.SIGN_IN_GOOGLE, false);
    }
  }

  Future<void> setStringValue(PreferencesKeys key, String? value) async {
    await _preferences!.setString(key.toString(), value ?? "null");
  }

  Future<void> setListValue(PreferencesKeys key, List<String> value) async {
    await _preferences!.setStringList(key.toString(), value);
  }

  Future<void> setBoolValue(PreferencesKeys key, bool value) async {
    await _preferences!.setBool(key.toString(), value);
  }

  String getStringValue(PreferencesKeys key) =>
      _preferences?.getString(key.toString()) ?? '';

  List<String>? getListValue(PreferencesKeys key) =>
      _preferences?.getStringList(key.toString()) ?? [];

  bool getBoolValue(PreferencesKeys key) =>
      _preferences!.getBool(key.toString()) ?? false;
}
