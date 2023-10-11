import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/pages/home/dashboard/dashboard_logic.dart';
import 'package:object_note/pages/home/home_state.dart';

class HomeLogic extends GetxController {
  @override
  void onInit() {
    super.onInit();
    worker = ever(state.currentIndex, (index) {
      if (index == 1) {
        Get.find<DashboardLogic>().onRefresh();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    worker.dispose();
  }

  final HomeState state = HomeState();
  final PageController pageController = PageController();
  late Worker worker;

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
