import 'package:flutter/material.dart';

import '../constants/app/app_constants.dart';
import 'app_theme.dart';
import 'light/color_scheme_light.dart';
import 'light/light_theme_interface.dart';
import 'light/text_theme_light.dart';

class AppThemeLight extends AppTheme implements ILightTheme {
  static BuildContext? context;
  static AppThemeLight? _instance;
  static AppThemeLight get instance {
    return _instance ??= AppThemeLight._init();
  }

  AppThemeLight._init();

  @override
  ThemeData get theme => ThemeData(
        brightness: Brightness.light,
        fontFamily: AppConstants.FONT_FAMILY,
        colorScheme: _appColorScheme,
        textTheme: textTheme(),
        appBarTheme: appBarTheme(),
        inputDecorationTheme: inputDecorationTheme(),
        textSelectionTheme: textSelectionTheme(),
        scaffoldBackgroundColor: colorSchemeLight!.background,
        elevatedButtonTheme: elevatedButtonTheme(),
        tabBarTheme: tabBarTheme,
        iconTheme: IconThemeData(color: colorSchemeLight!.black, size: 20),
        dividerTheme: const DividerThemeData()
            .copyWith(color: colorSchemeLight!.darkGrey),
        bottomNavigationBarTheme: bottomNavigationBarTheme(),
        cardTheme: CardTheme(
          color: colorSchemeLight!.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );

  BottomNavigationBarThemeData bottomNavigationBarTheme() {
    return BottomNavigationBarThemeData(
      backgroundColor: colorSchemeLight!.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 1,
      type: BottomNavigationBarType.fixed,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
    );
  }

  AppBarTheme appBarTheme() {
    return ThemeData.light().appBarTheme.copyWith(
          backgroundColor: colorSchemeLight!.background,
          elevation: 0,
          iconTheme: IconThemeData(color: colorSchemeLight!.black, size: 16),
          titleTextStyle: textThemeLight!.displayLarge,
          centerTitle: false,
        );
  }

  ElevatedButtonThemeData elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            width: 0.6,
            color: colorSchemeLight!.lightBlack,
          ),
        ),
        backgroundColor: colorSchemeLight!.white,
        elevation: 0,
        padding: EdgeInsets.zero,
      ),
    );
  }

  TextSelectionThemeData textSelectionTheme() {
    return TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: _appColorScheme.surface,
      selectionHandleColor: _appColorScheme.surface,
    );
  }

  InputDecorationTheme inputDecorationTheme() {
    return InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
    );
  }

  TabBarTheme get tabBarTheme {
    return TabBarTheme(
      labelColor: _appColorScheme.onSecondary,
      labelStyle: textThemeLight!.titleLarge,
      unselectedLabelColor: _appColorScheme.onSecondary.withOpacity(0.2),
    );
  }

  TextTheme textTheme() {
    return ThemeData.light().textTheme.copyWith(
          displayLarge: textThemeLight!.displayLarge,
          displayMedium: textThemeLight!.titleLarge,
          bodySmall: textThemeLight!.bodySmall,
          titleMedium: textThemeLight!.titleSmall,
        );
  }

  ColorScheme get _appColorScheme {
    return ColorScheme(
        primary: colorSchemeLight!.blue,
        secondary: colorSchemeLight!.lightBlue,
        surface: colorSchemeLight!.lightBlue,
        background: colorSchemeLight!.background,
        error: Colors.red[900]!,
        onPrimary: colorSchemeLight!.darkGrey,
        onSecondary: colorSchemeLight!.white,
        onSurface: colorSchemeLight!.black,
        onBackground: colorSchemeLight!.grey,
        onError: const Color(0xFFF9B916),
        brightness: Brightness.light);
  }

  @override
  ColorSchemeLight? colorSchemeLight = ColorSchemeLight.instance;

  @override
  TextThemeLight? textThemeLight = TextThemeLight.instance;
}
