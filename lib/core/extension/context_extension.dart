import 'dart:math';

import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  double get lowValue => height * 0.01;
  double get normalValue => height * 0.02;
  double get mediumValue => height * 0.04;
  double get highValue => height * 0.2;
  double get cardValue => height * 0.9;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
}

extension SizedBoxExtensionVertical on BuildContext {
  Widget get lowSizedBoxVertical => SizedBox(height: lowValue / 2);
  Widget get normalSizedBoxVertical => SizedBox(height: lowValue * 1.5);
  Widget get highSizedBoxVertical => SizedBox(height: lowValue * 2);
  Widget get topSizedBox => SizedBox(
        height: mediaQuery.padding.top,
      );
}

extension SizedBoxExtensionHorizontal on BuildContext {
  Widget get lowSizedBoxHorizontal => SizedBox(width: lowValue);
  Widget get normalSizedBoxHorizontal => SizedBox(width: lowValue * 1.5);
  Widget get highSizedBoxHorizontal => SizedBox(width: lowValue * 2);
}

extension PaddingExtensionAll on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);
}

extension PaddingExtensionSymetric on BuildContext {
  EdgeInsets get paddingLowVertical => EdgeInsets.symmetric(vertical: lowValue);
  EdgeInsets get paddingNormalVertical =>
      EdgeInsets.symmetric(vertical: normalValue);
  EdgeInsets get paddingMediumVertical =>
      EdgeInsets.symmetric(vertical: mediumValue);
  EdgeInsets get paddingHighVertical =>
      EdgeInsets.symmetric(vertical: highValue);

  EdgeInsets get paddingMediumHoriztalLowVertical =>
      EdgeInsets.symmetric(horizontal: mediumValue, vertical: lowValue);

  EdgeInsets get paddingLowHorizontal =>
      EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get paddingNormalHorizontal =>
      EdgeInsets.symmetric(horizontal: normalValue);
  EdgeInsets get paddingMediumHorizontal =>
      EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get paddingHighHorizontal =>
      EdgeInsets.symmetric(horizontal: highValue);
}

extension PageExtension on BuildContext {
  Color get randomColor => Colors.primaries[Random().nextInt(17)];
}

extension DurationExtension on BuildContext {
  Duration get lowDuration => const Duration(milliseconds: 500);
  Duration get highDuration => const Duration(milliseconds: 700);
  Duration get normalDuration => const Duration(seconds: 1);
}
