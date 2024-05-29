import 'package:dio/dio.dart';

import '../../constants/enums/locale_keys_enum.dart';
import '../cache/locale_manager.dart';
import 'ICoreDio.dart';
import 'core_dio.dart';

class NetworkManagerLocale {
  static NetworkManagerLocale? _instance;
  static NetworkManagerLocale? get instance {
    _instance ??= NetworkManagerLocale._init();
    return _instance;
  }

  ICoreDioNullSafety? coreDio;

  NetworkManagerLocale._init() {
    final baseOptions = BaseOptions(
      baseUrl: 'http://165.22.77.208:3030',
      headers: {
        'Authorization':
            'Bearer ${LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN)}'
      },
    );
    // _dio = Dio(baseOptions);

    coreDio = CoreDio(baseOptions);

    // _dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (options) {
    //     options.path += "veli";
    //   },
    //   onError: (e) {
    //     return BaseError(e.message);
    //   },
    // ));
  }
}
