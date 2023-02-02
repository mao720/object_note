import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_config.dart';
import 'home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();
  final PageController pageController = PageController();

  onPageChanged(int index) {
    state.currentIndex.value = index;
  }

  onSettingButtonPressed() {
    Get.toNamed(RouteConfig.settingsPage);
  }

  onListTilePressed(String title) {
    switch (title) {
      case 'Splash Page':
        Get.toNamed(RouteConfig.splashPage);
        break;
      case 'Guide Page':
        Get.toNamed(RouteConfig.guidePage);
        break;
    }
  }

  onDestinationSelected(int index) {
    state.currentIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
}
