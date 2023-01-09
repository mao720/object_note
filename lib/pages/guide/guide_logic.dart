import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/config.dart';

class GuideLogic extends GetxController with GetTickerProviderStateMixin {
  var currentPageIndex = 0.obs;
  var pageController = PageController();
  var guideIllustrations = AppConfig.guideIllustrations;
  late List<AnimationController> animationControllerList = guideIllustrations
      .map((illustration) => AnimationController(vsync: this))
      .toList();

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      var page = pageController.page ?? 0;
      animationControllerList[page.toInt()].value = 1 - (page - page.toInt());
      if (animationControllerList.length > page.toInt() + 1) {
        animationControllerList[page.toInt() + 1].value = page - page.toInt();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    if (animationControllerList.isNotEmpty) {
      animationControllerList[0]
        ..duration = const Duration(seconds: 3)
        ..forward();
    }
  }

  void onButtonPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstOpen', false);
    Get.toNamed(RouteGet.testPage);
  }
}
