import 'package:flutter/material.dart';

class ColorSchemeLight {
  static ColorSchemeLight? _instace;
  static ColorSchemeLight? get instance {
    _instace ??= ColorSchemeLight._init();
    return _instace;
  }

  ColorSchemeLight._init();

  final Color background = const Color(0xffF5F6F7);
  final Color white = const Color(0xffFFFFFF);
  final Color black = const Color(0xff1B1B1B);
  final Color lightBlack = const Color(0xff484C52);
  final Color blue = const Color(0xff4F8FC0);
  final Color lightBlue = const Color(0xff52B6FE);
  final Color grey = const Color(0xffE7E7E7);
  final Color darkGrey = const Color(0xffAEAEAE);
}
