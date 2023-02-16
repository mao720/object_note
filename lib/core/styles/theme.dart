import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/app/global.dart';

class Themes {
  Themes._();

  static ColorScheme get cs => Theme.of(Global.context).colorScheme;
  static const designSize = Size(360, 690);
  static const fontFamily = 'LXGWWenKaiLite';
  static final Rx<ThemeMode> themeMode = ThemeMode.system.obs;
  static final RxString locale = ''.obs;
  static const fallbackLocale = Locale('en');

  static final lightThemeData = ThemeData(
    useMaterial3: true,
    platform: TargetPlatform.iOS,
    colorScheme: Themes.lightColorScheme,
    fontFamily: Themes.fontFamily,
  );

  static final darkThemeData = ThemeData(
    useMaterial3: true,
    platform: TargetPlatform.iOS,
    colorScheme: Themes.darkColorScheme,
    fontFamily: Themes.fontFamily,
  );

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF1D6C30),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFA5F5A9),
    onPrimaryContainer: Color(0xFF002107),
    secondary: Color(0xFF984800),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFFFDBC8),
    onSecondaryContainer: Color(0xFF311300),
    tertiary: Color(0xFF006782),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFBBE9FF),
    onTertiaryContainer: Color(0xFF001F29),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFF5FFF3),
    onBackground: Color(0xFF00210E),
    surface: Color(0xFFF5FFF3),
    onSurface: Color(0xFF00210E),
    surfaceVariant: Color(0xFFDEE5D9),
    onSurfaceVariant: Color(0xFF424940),
    outline: Color(0xFF727970),
    onInverseSurface: Color(0xFFC2FFD0),
    inverseSurface: Color(0xFF00391C),
    inversePrimary: Color(0xFF89D88F),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF1D6C30),
    // outlineVariant: Color(0xFFC1C9BE),
    // scrim: Color(0xFF000000),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF89D88F),
    onPrimary: Color(0xFF003912),
    primaryContainer: Color(0xFF00531D),
    onPrimaryContainer: Color(0xFFA5F5A9),
    secondary: Color(0xFFFFB689),
    onSecondary: Color(0xFF512300),
    secondaryContainer: Color(0xFF733500),
    onSecondaryContainer: Color(0xFFFFDBC8),
    tertiary: Color(0xFF60D4FE),
    onTertiary: Color(0xFF003545),
    tertiaryContainer: Color(0xFF004D63),
    onTertiaryContainer: Color(0xFFBBE9FF),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF00210E),
    onBackground: Color(0xFF99F7B5),
    surface: Color(0xFF00210E),
    onSurface: Color(0xFF99F7B5),
    surfaceVariant: Color(0xFF424940),
    onSurfaceVariant: Color(0xFFC1C9BE),
    outline: Color(0xFF8C9389),
    onInverseSurface: Color(0xFF00210E),
    inverseSurface: Color(0xFF99F7B5),
    inversePrimary: Color(0xFF1D6C30),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF89D88F),
    // outlineVariant: Color(0xFF424940),
    // scrim: Color(0xFF000000),
  );
}
