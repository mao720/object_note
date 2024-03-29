import 'package:flutter/material.dart';
import 'package:object_note/core/styles/theme.dart';
import 'package:object_note/core/styles/translation.dart';

class StringUtils {
  /// String to Locale
  static Locale stringToLocale(String? source, Locale? deviceLocale) {
    return Translation.supportLocale.firstWhere(
        (locale) => locale.toString() == source,
        orElse: () => deviceLocale ?? Themes.fallbackLocale);
  }

  /// String to Color
  static Color stringToColor(String source) {
    return Color(int.parse(source, radix: 16) | 0xFF000000);
  }

  /// Color to MaterialColor
  static MaterialColor colorToMaterialColor(Color color) {
    List<double> strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
