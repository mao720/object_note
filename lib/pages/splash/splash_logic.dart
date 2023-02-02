import 'dart:async';

import 'package:get/get.dart';

class SplashLogic extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var isFirstOpen = prefs.getBool('isFirstOpen') ?? true;
    // Timer(const Duration(seconds: 2), () {
    //   Get.offNamed(isFirstOpen ? RouteConfig.guidePage : RouteConfig.homePage);
    // });
  }
}
