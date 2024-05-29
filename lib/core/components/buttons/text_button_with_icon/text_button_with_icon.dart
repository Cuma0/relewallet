import 'package:flutter/material.dart';

import '../../../extension/context_extension.dart';
import '../../../theme/light/text_theme_light.dart';

TextButton textbuttonWithPic({
  required String text,
  required bool isBigSize,
  required BuildContext context,
  required String pic,
  required void Function()? onPressed,
}) {
  return TextButton(
    onPressed: onPressed,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: isBigSize
              ? TextThemeLight.instance!.titleLarge
              : TextThemeLight.instance!.button,
        ),
        context.lowSizedBoxHorizontal,
        Image.asset(
          pic,
          fit: BoxFit.cover,
          height: 26,
        ),
        context.lowSizedBoxHorizontal,
      ],
    ),
  );
}
