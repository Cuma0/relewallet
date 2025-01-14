import 'color_scheme_dark.dart';
import 'text_theme_dark.dart';

abstract class IDarkTheme {
  TextThemeDark? textThemeDark = TextThemeDark.instance;
  ColorSchemeDark? colorSchemeDark = ColorSchemeDark.instance;
}
