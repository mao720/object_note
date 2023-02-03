import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../core/app_config.dart';
import 'splash_logic.dart';

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
              AssetsIndex.splashLogo,
              repeat: false,
              width: ThemeConfig.iconLarge,
              height: ThemeConfig.iconLarge,
            ),
            Lottie.asset(AssetsIndex.yogaBoxBreathing)
          ],
        ),
      ),
    );
  }
}
