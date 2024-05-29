import 'package:flutter/material.dart';

import '../../../extension/string_extension.dart';
import '../../../init/lang/locale_keys.g.dart';
import '../../../theme/light/color_scheme_light.dart';
import '../../../theme/light/text_theme_light.dart';

ElevatedButton buttonWithPic(
    {required void Function() onPressed,
    required BuildContext context,
    String? image,
    IconData? icon,
    String? text}) {
  return ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shadowColor: Colors.white,
      foregroundColor: ColorSchemeLight.instance!.darkGrey,
      backgroundColor: ColorSchemeLight.instance!.white,
    ),
    icon: image != null
        ? Image.asset(
            image,
            fit: BoxFit.cover,
            height: 24,
          )
        : Icon(
            icon,
            color: ColorSchemeLight.instance!.blue,
            size: 24,
          ),
    label: Text(
      text ?? LocaleKeys.account_page_sign_up_page_sign_in_google.locale,
      style: TextThemeLight.instance!.buttonSmall,
    ),
    onPressed: onPressed,
  );
}
