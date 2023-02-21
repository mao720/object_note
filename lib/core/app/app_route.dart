import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/app/global.dart';
import 'package:object_note/pages/guide/guide_view.dart';
import 'package:object_note/pages/home/home_view.dart';
import 'package:object_note/pages/login/login_view.dart';
import 'package:object_note/pages/profile/profile_view.dart';
import 'package:object_note/pages/settings/settings_view.dart';
import 'package:object_note/pages/splash/splash_view.dart';

class AppRoute {
  static const String splashPage = "/splashPage";
  static const String guidePage = "/guidePage";
  static const String homePage = "/homePage";
  static const String settingsPage = "/settingsPage";
  static const String loginPage = "/loginPage";
  static const String profilePage = "/profilePage";

  static final List<GetPage> getPages = [
    GetPage(name: splashPage, page: () => SplashPage()),
    GetPage(name: guidePage, page: () => GuidePage()),
    GetPage(name: homePage, page: () => HomePage()),
    GetPage(name: settingsPage, page: () => SettingsPage()),
    GetPage(name: loginPage, page: () => LoginPage()),
    GetPage(
      name: profilePage,
      page: () => ProfilePage(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (Global.user.value != null || route == AppRoute.loginPage) {
      return null;
    } else {
      return const RouteSettings(name: AppRoute.loginPage);
    }
  }
}
