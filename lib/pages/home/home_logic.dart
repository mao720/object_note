import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/route.dart';
import 'package:object_note/pages/home/home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();
  final PageController pageController = PageController();

  onSettingButtonPressed() async {
    Get.toNamed(AppRoute.settingsPage);
  }

  onListTilePressed(String title) {
    switch (title) {
      case 'Splash Page':
        Get.toNamed(AppRoute.splashPage);
        break;
      case 'Guide Page':
        Get.toNamed(AppRoute.guidePage);
        break;
    }
  }

  onPageChanged(int index) {
    state.currentIndex.value = index;
  }

  onDestinationSelected(int index) {
    state.currentIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  onUserHeaderPressed() {
    Get.toNamed(AppRoute.loginPage);
  }
}
