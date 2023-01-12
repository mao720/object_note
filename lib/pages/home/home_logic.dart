import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();
  final PageController pageController = PageController();
  final currentIndex = 0.obs;
}
