import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:object_note/core/assets.dart';
import 'package:object_note/pages/splash/splash_logic.dart';
import 'package:object_note/utils/screen_adaption_util.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  final logic = Get.put(SplashLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              Assets.splashLogo,
              repeat: false,
              width: 96.w,
              height: 96.w,
            ),
            Lottie.asset(Assets.yogaBoxBreathing)
          ],
        ),
      ),
    );
  }
}
