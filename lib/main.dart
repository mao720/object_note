import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/common/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Get.lazyPut<ThemeController>(() => ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromPreferences();
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: RouteGet.splashPage,
      getPages: RouteGet.getPages,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'LXGWWenKaiLite',
        primarySwatch: Colors.green,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'LXGWWenKaiLite',
      ),
    );
  }
}

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  var themeMode = ThemeMode.system.obs;

  Future<void> setThemeMode(ThemeMode themeMode) async {
    Get.changeThemeMode(themeMode);
    this.themeMode(themeMode);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', describeEnum(themeMode));
  }

  getThemeModeFromPreferences() async {
    ThemeMode themeMode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String themeText = prefs.getString('theme') ?? 'system';
    try {
      themeMode =
          ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
    } catch (e) {
      themeMode = ThemeMode.system;
    }
    setThemeMode(themeMode);
  }
}
