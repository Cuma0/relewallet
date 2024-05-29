import 'dart:io';

import 'package:vexana/vexana.dart';

import '../../constants/enums/locale_keys_enum.dart';
import '../cache/locale_manager.dart';

class VexanaManager {
  static VexanaManager? _instace;
  static late String token;
  static VexanaManager get instance {
    if (_instace != null && token.length > 10) {
      return _instace!;
    }
    token = LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN);
    _instace = VexanaManager._init();
    return _instace!;
  }

  void setToken(String newToken) {
    token = newToken;
  }

  // PROD
  static const String _iosBaseUrl = 'https://relewallet.com';

  // PROD
  static const String _androidBaseUrl = 'https://relewallet.com';

  VexanaManager._init();

  Future<String> getToken() async {
    final token = LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN);
    return token;
  }

  INetworkManager networkManager = NetworkManager<Null>(
    isEnableLogger: true,
    options: BaseOptions(
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      baseUrl: Platform.isAndroid ? _androidBaseUrl : _iosBaseUrl,
    ),
  );
}
