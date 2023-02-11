import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/http.dart';
import 'package:object_note/pages/guide/guide_state.dart';
import 'package:object_note/utils/log_util.dart';
import 'package:object_note/widgets/toast.dart';

class GuideLogic extends GetxController with GetTickerProviderStateMixin {
  final GuideState state = GuideState();
  var pageController = PageController();
  late List<AnimationController> animationControllerList = state
      .guideIllustrations
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

  @override
  void onClose() {
    if (animationControllerList.isNotEmpty) {
      animationControllerList[0].dispose();
    }
    super.onClose();
  }

  void onButtonPressed() async {
    Http().get('classes/_User').then((value) => Log.d(value.toString()));
    if (Toast.isShow) {
      Toast.dismiss();
      // Toast.progress(0.6,text: 'onButton');
    } else {
      Toast.progress(0.6, text: 'onButton');
    }
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('isFirstOpen', false);
    // Get.offNamed(RouteConfig.homePage);
  }
}
