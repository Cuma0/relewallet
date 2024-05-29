import 'package:flutter/material.dart';

import '../../init/cache/locale_manager.dart';
import '../../init/network/ICoreDio.dart';
import '../../init/network/network_manager.dart';
import '../../init/network/vexana_manager.dart';

mixin BaseViewModel {
  BuildContext? myContext;

  ICoreDioNullSafety? coreDio = NetworkManagerLocale.instance!.coreDio;

  VexanaManager? vexanaManager = VexanaManager.instance;

  VexanaManager get vexanaManagerComputed => VexanaManager.instance;

  LocaleManager localeManager = LocaleManager.instance;
}
