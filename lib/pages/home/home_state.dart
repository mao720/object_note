import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeState {
  Rx<List<List>> bottomTabItems = Rx([
    ['Home'.tr, Icons.home, Icons.home_outlined],
    ['Mine'.tr, Icons.account_box, Icons.account_box_outlined],
  ]);

  RxInt currentIndex = 0.obs;

  HomeState() {
    ///Initialize variables
  }
}
