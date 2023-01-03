import 'package:get/get.dart';
import 'package:object_note/pages/guide/guide_view.dart';
import 'package:object_note/pages/splash/splash_view.dart';
import 'package:object_note/pages/test/test_view.dart';

class RouteGet {
  ///root page
  static const String splashPage = "/";
  static const String guidePage = "/guidePage";
  static const String testPage = "/testPage";

  ///pages map
  static final List<GetPage> getPages = [
    GetPage(name: splashPage, page: () => SplashPage()),
    GetPage(name: guidePage, page: () => GuidePage()),
    GetPage(
        name: testPage, page: () => TestPage(title: 'Flutter Demo Home Page')),
  ];
}
