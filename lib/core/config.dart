import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/guide/guide_view.dart';
import '../pages/home/home_view.dart';
import '../pages/splash/splash_view.dart';
import '../pages/test/test_view.dart';

class RouteGet {
  ///root page
  static const String splashPage = "/splashPage";
  static const String guidePage = "/guidePage";
  static const String homePage = "/homePage";
  static const String testPage = "/testPage";

  ///pages map
  static final List<GetPage> getPages = [
    GetPage(name: splashPage, page: () => SplashPage()),
    GetPage(name: guidePage, page: () => GuidePage()),
    GetPage(name: testPage, page: () => TestPage()),
    GetPage(name: homePage, page: () => HomePage()),
  ];
}

class AppConfig {
  static const fontFamily = 'LXGWWenKaiLite';

  static const splashLogo = 'assets/animations/logo-somar.json';

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF3A6A1D),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFBAF295),
    onPrimaryContainer: Color(0xFF092100),
    secondary: Color(0xFF984800),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFFFDBC8),
    onSecondaryContainer: Color(0xFF311300),
    tertiary: Color(0xFF00639C),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFCFE5FF),
    onTertiaryContainer: Color(0xFF001D33),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFDFDF5),
    onBackground: Color(0xFF1A1C18),
    surface: Color(0xFFFDFDF5),
    onSurface: Color(0xFF1A1C18),
    surfaceVariant: Color(0xFFE0E4D6),
    onSurfaceVariant: Color(0xFF43483E),
    outline: Color(0xFF74796D),
    onInverseSurface: Color(0xFFF1F1EA),
    inverseSurface: Color(0xFF2F312C),
    inversePrimary: Color(0xFF9FD67B),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF3A6A1D),
    // outlineVariant: Color(0xFFC4C8BB),
    // scrim: Color(0xFF000000),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF9FD67B),
    onPrimary: Color(0xFF153800),
    primaryContainer: Color(0xFF235104),
    onPrimaryContainer: Color(0xFFBAF295),
    secondary: Color(0xFFFFB689),
    onSecondary: Color(0xFF512300),
    secondaryContainer: Color(0xFF733500),
    onSecondaryContainer: Color(0xFFFFDBC8),
    tertiary: Color(0xFF98CBFF),
    onTertiary: Color(0xFF003354),
    tertiaryContainer: Color(0xFF004A77),
    onTertiaryContainer: Color(0xFFCFE5FF),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF1A1C18),
    onBackground: Color(0xFFE3E3DC),
    surface: Color(0xFF1A1C18),
    onSurface: Color(0xFFE3E3DC),
    surfaceVariant: Color(0xFF43483E),
    onSurfaceVariant: Color(0xFFC4C8BB),
    outline: Color(0xFF8E9286),
    onInverseSurface: Color(0xFF1A1C18),
    inverseSurface: Color(0xFFE3E3DC),
    inversePrimary: Color(0xFF3A6A1D),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF9FD67B),
    // outlineVariant: Color(0xFF43483E),
    // scrim: Color(0xFF000000),
  );

  static const bottomTabItems = [
    Icons.home,
    Icons.account_box,
  ];

  static const guideIllustrations = [
    'assets/animations/illustration-stay-at-home.json',
    'assets/animations/illustration-book.json',
    'assets/animations/illustration-bookshelf.json',
    'assets/animations/illustration-heart.json',
    'assets/animations/illustration-planting-trees.json',
    'assets/animations/illustration-walking.json',
    'assets/animations/illustration-watering-flowers.json',
  ];
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
