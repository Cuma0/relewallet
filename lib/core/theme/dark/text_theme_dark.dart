import 'package:flutter/material.dart';

class TextThemeDark {
  static TextThemeDark? _instace;
  static TextThemeDark? get instance {
    _instace ??= TextThemeDark._init();
    return _instace;
  }

  TextThemeDark._init();

  final TextStyle headline1 =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white);

  /// SLIDER MENU BUTTONS


  final TextStyle headline2 =const  TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Colors.white);

  /// SERVICES BUTTON
  
  final TextStyle headline3 = const TextStyle(
    fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Color(0xff969696)
  ); 
  /// TEXTFIELD HINT TEXT

   final TextStyle headline4 =const  TextStyle(
    fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.white
  ); 
   /// TEXTFIELD TEXT

     final TextStyle bodyText1 =const
      TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white);

  /// BOLD TITLE


    final TextStyle bodyText2 = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Color(0xffD2D2D2));

  /// BODY TEXT

      final TextStyle button =const
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white);

  /// BUTTON

    final TextStyle subtitle1 =const
      TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.white);
  /// SELF-CARE PAGE BOLD - COPYWITH MEDIUM - FONTSIZE 11 W200 TARIH
  
    final TextStyle caption =const
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white);
  /// APP-BAR TITLE
}


