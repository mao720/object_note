import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../core/config.dart';
import 'guide_logic.dart';

class GuidePage extends StatelessWidget {
  GuidePage({Key? key}) : super(key: key);

  final logic = Get.put(GuideLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: AppConfig.guideIllustrations
                .map((illustration) => Lottie.asset(illustration))
                .toList(),
          )
        ],
      ),
    );
  }
}
