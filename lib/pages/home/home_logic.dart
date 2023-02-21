import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/pages/home/home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();
  final PageController pageController = PageController();

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
