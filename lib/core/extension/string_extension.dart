import 'package:easy_localization/easy_localization.dart';

import '../constants/app/app_constants.dart';

extension StringLocalization on String {
  String get locale => this.tr();

  String? get isValidEmail => contains(RegExp(AppConstants.EMAIL_REGIEX))
      ? null
      : 'Email does not valid';

  bool get isValidEmails => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);
}

extension ImagePathExtension on String {
  String get toSVG => 'asset/svg/$this.svg';
}
