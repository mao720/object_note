import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeState {
  Rx<List<IconData>> bottomTabItems = Rx([
    Icons.home,
    Icons.account_box,
  ]);

  RxInt currentIndex = 0.obs;

  HomeState() {
    ///Initialize variables
  }
}
