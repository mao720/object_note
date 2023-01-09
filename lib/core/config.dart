import 'package:get/get.dart';

import '../pages/guide/guide_view.dart';
import '../pages/splash/splash_view.dart';
import '../pages/test/test_view.dart';

class RouteGet {
  ///root page
  static const String splashPage = "/splashPage";
  static const String guidePage = "/guidePage";
  static const String testPage = "/testPage";

  ///pages map
  static final List<GetPage> getPages = [
    GetPage(name: splashPage, page: () => SplashPage()),
    GetPage(name: guidePage, page: () => GuidePage()),
    GetPage(name: testPage, page: () => TestPage()),
  ];
}

class AppConfig {
  static const splashLogo = 'assets/animations/logo-somar.json';

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
