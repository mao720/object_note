import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'splash_logic.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  final _logic = Get.put(SplashLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Lottie.asset('assets/animations/stay-at-home.json',
          width: 100, height: 100),
    ));
  }
}
