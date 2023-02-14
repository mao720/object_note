import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/http.dart';
import 'package:object_note/core/route.dart';
import 'package:object_note/pages/home/home_state.dart';
import 'package:object_note/utils/log_util.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();
  final PageController pageController = PageController();

  onSettingButtonPressed() async {
    var data = await Http().get('classes/_User');
    Log.d(data.toString());
    //Http().cancelToken.cancel();

    //Get.toNamed(AppRoute.settingsPage);
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
}
