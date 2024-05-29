import 'package:flutter/material.dart';

import '../constants/app/app_constants.dart';
import 'app_theme.dart';
import 'dark/color_scheme_dark.dart';
import 'dark/dark_theme_interface.dart';
import 'dark/text_theme_dark.dart';

class AppThemeDark extends AppTheme implements IDarkTheme {
  static BuildContext? context;
  static AppThemeDark? _instance;
  static AppThemeDark get instance {
    return _instance ??= AppThemeDark._init();
  }

  AppThemeDark._init();

  @override
  ThemeData get theme => ThemeData(
        brightness: Brightness.light,
        fontFamily: AppConstants.FONT_FAMILY,
        colorScheme: _appColorScheme,
        textTheme: textTheme(),
        appBarTheme: ThemeData.dark().appBarTheme.copyWith(
              color: const Color(0xff2A2A2A),
              elevation: 1,
              iconTheme: const IconThemeData(color: Colors.white, size: 21),
              titleTextStyle: TextThemeDark.instance!.caption,
              centerTitle: true,
            ),
        inputDecorationTheme: inputDecorationTheme(),
        textSelectionTheme: textSelectionTheme(),
        scaffoldBackgroundColor: const Color(0xff1C1C1C),
        floatingActionButtonTheme:
            ThemeData.dark().floatingActionButtonTheme.copyWith(
                  backgroundColor: Colors.green,
                ),
        buttonTheme: ThemeData.dark().buttonTheme.copyWith(
              colorScheme: const ColorScheme.dark(
                onError: Color(0xffFF2D55),
              ),
            ),
        elevatedButtonTheme: elevatedButtonTheme(),
        tabBarTheme: tabBarTheme,
        iconTheme: const IconThemeData(color: Colors.white, size: 18),
        dividerTheme:
            const DividerThemeData().copyWith(color: const Color(0xff424242)),
      );
  ElevatedButtonThemeData elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: const Color(0xff131313),
        foregroundColor: const Color.fromRGBO(151, 151, 151, 100),
      ),
    );
  }

  TextSelectionThemeData textSelectionTheme() {
    return TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: _appColorScheme.surface,
      selectionHandleColor: _appColorScheme.surface,
    );
  }

  InputDecorationTheme inputDecorationTheme() {
    return InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xff2F2F2F),
        hintStyle: TextThemeDark.instance!.headline3,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xff2F2F2F), width: 3.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xff2F2F2F), width: 3.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 3.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 3.0),
        ),
        errorStyle: textThemeDark!.headline3.copyWith(color: Colors.red));
  }

  TabBarTheme get tabBarTheme {
    return TabBarTheme(
      labelColor: _appColorScheme.background,
      labelStyle: textThemeDark!.headline2,
      unselectedLabelColor: _appColorScheme.onSecondary.withOpacity(0.2),
      // unselectedLabelStyle: textThemeLight.headline4.copyWith(color: colorSchemeLight.red),
    );
  }

  TextTheme textTheme() {
    return ThemeData.dark().textTheme.copyWith(
          displayLarge: textThemeDark!.headline1,
          displayMedium: textThemeDark!.headline2,
          displaySmall: textThemeDark!.headline3,
          headlineMedium: textThemeDark!.headline4,
          bodyLarge: textThemeDark!.bodyText1,
          bodyMedium: textThemeDark!.bodyText2,
          labelLarge: textThemeDark!.button,
          titleMedium: textThemeDark!.subtitle1,
        );
  }

  ColorScheme get _appColorScheme {
    return ColorScheme(
        primary: colorSchemeDark!.black,
        secondary: Colors.green,
        surface: Colors.blue, //xx
        background: const Color(0xfff6f9fc), //xx
        error: Colors.red[900]!,
        onPrimary: Colors.greenAccent,
        onSecondary: Colors.black, //x
        onSurface: Colors.purple.shade300,
        onBackground: Colors.black12,
        onError: const Color(0xFFF9B916), //xx
        brightness: Brightness.light);
  }

  @override
  ColorSchemeDark? colorSchemeDark = ColorSchemeDark.instance;

  @override
  TextThemeDark? textThemeDark = TextThemeDark.instance;
}
