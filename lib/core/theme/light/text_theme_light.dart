import 'package:flutter/material.dart';

import '../../constants/app/app_constants.dart';
import 'color_scheme_light.dart';

class TextThemeLight {
  static TextThemeLight? _instace;
  static TextThemeLight? get instance {
    _instace ??= TextThemeLight._init();
    return _instace;
  }

  TextThemeLight._init();

  final TextStyle displayLarge = TextStyle(
      // Appbar Title
      fontFamily: AppConstants.FONT_FAMILY,
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: ColorSchemeLight.instance!.black);

  final TextStyle titleLarge = TextStyle(
    // Cards Page "My Cards"
    fontFamily: AppConstants.FONT_FAMILY,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: ColorSchemeLight.instance!.black,
  );

  final TextStyle titleSmall = TextStyle(
      // Offers Page "For you", Account Page "Settings and titles"
      fontFamily: AppConstants.FONT_FAMILY,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: ColorSchemeLight.instance!.lightBlack);

  final TextStyle bodySmall = TextStyle(
      // Offers Page "Validity Period"
      fontFamily: AppConstants.FONT_FAMILY,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: ColorSchemeLight.instance!.lightBlack);

  final TextStyle bodyLarge = TextStyle(
    //No Account
    fontFamily: AppConstants.FONT_FAMILY,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: ColorSchemeLight.instance!.lightBlack,
  );

  final TextStyle button = TextStyle(
    fontFamily: AppConstants.FONT_FAMILY,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: ColorSchemeLight.instance!.black,
  );
  final TextStyle buttonSmall = TextStyle(
    fontFamily: AppConstants.FONT_FAMILY,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ColorSchemeLight.instance!.black,
  );

  //////
  //////
  //////
  //////
  //////
  //////
  //////
  //////
  //////
  //////
  //////
  //////
  //////
  //////
}
