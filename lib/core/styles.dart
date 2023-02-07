import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/utils/string_utils.dart';

class Styles {
  static const fontFamily = 'LXGWWenKaiLite';
  static final themeMode = ThemeMode.system.obs;
  static final locale = 'system'.obs;
  static const fallbackLocale = Locale('en');

  static final lightThemeData = ThemeData(
    useMaterial3: true,
    platform: TargetPlatform.iOS,
    colorScheme: Styles.lightColorScheme,
    primarySwatch: StringUtils.colorToMaterialColor(lightColorScheme.primary),
    toggleableActiveColor: Styles.lightColorScheme.primary,
    backgroundColor: Styles.lightColorScheme.background,
    scaffoldBackgroundColor: Styles.lightColorScheme.background,
    fontFamily: Styles.fontFamily,
  );

  static final darkThemeData = ThemeData(
    useMaterial3: true,
    platform: TargetPlatform.iOS,
    colorScheme: Styles.darkColorScheme,
    primarySwatch: StringUtils.colorToMaterialColor(darkColorScheme.primary),
    toggleableActiveColor: Styles.darkColorScheme.primary,
    backgroundColor: Styles.darkColorScheme.background,
    scaffoldBackgroundColor: Styles.darkColorScheme.background,
    fontFamily: Styles.fontFamily,
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
    surface: Color(0xFFF0FFEE),
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

  static const paddingXXXLarge = 96.0;
  static const paddingXXLarge = 64.0;
  static const paddingXLarge = 48.0;
  static const paddingLarge = 32.0;
  static const paddingLMedium = 28.0;
  static const paddingMedium = 24.0;
  static const paddingEMedium = 20.0;
  static const paddingSmall = 16.0;
  static const paddingESmall = 12.0;
  static const paddingEESmall = 8.0;
  static const paddingEEESmall = 4.0;

  static const radiusXXXLarge = 128.0;
  static const radiusXXLarge = 64.0;
  static const radiusXLarge = 36.0;
  static const radiusLarge = 24.0;
  static const radiusXMedium = 16.0;
  static const radiusMedium = 14.0;
  static const radiusEMedium = 12.0;
  static const radiusSmall = 10.0;
  static const radiusESmall = 8.0;
  static const radiusEESmall = 6.0;
  static const radiusEEESmall = 4.0;

  static const iconXXXLarge = 256.0;
  static const iconXXLarge = 192.0;
  static const iconXLarge = 144.0;
  static const iconLarge = 96.0;
  static const iconXMedium = 72.0;
  static const iconMedium = 64.0;
  static const iconEMedium = 48.0;
  static const iconSmall = 32.0;
  static const iconESmall = 24.0;
  static const iconEESmall = 16.0;
  static const iconEEESmall = 12.0;
  static const iconEEEESmall = 8.0;
}
