import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../core/app_config.dart';
import 'guide_logic.dart';

class GuidePage extends StatelessWidget {
  GuidePage({Key? key}) : super(key: key);

  final logic = Get.put(GuideLogic());
  final state = Get.find<GuideLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        PageView(
          onPageChanged: (index) => state.currentPageIndex.value = index,
          controller: logic.pageController,
          children: AppConfig.guideIllustrations
              .asMap()
              .entries
              .map((entry) => Lottie.asset(entry.value,
                  controller: logic.animationControllerList[entry.key]))
              .toList(),
        ),
        Column(children: [
          Flexible(flex: 17, child: Container()),
          Flexible(
            flex: 3,
            child: Obx(() {
              return state.currentPageIndex.value ==
                      AppConfig.guideIllustrations.length - 1
                  ? TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.resolveWith(
                            (states) => const EdgeInsets.all(12)),
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.green.withOpacity(0.2)),
                      ),
                      onPressed: logic.onButtonPressed,
                      child: Text(
                        'Start Note'.tr,
                        style:
                            const TextStyle(fontSize: 22, color: Colors.green),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: AppConfig.guideIllustrations
                          .asMap()
                          .keys
                          .map((index) => Obx(() {
                                return Container(
                                  width: 8,
                                  height: 8,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: state.currentPageIndex.value == index
                                        ? Colors.grey
                                        : Colors.grey.withOpacity(0.3),
                                  ),
                                );
                              }))
                          .toList());
            }),
          )
        ]),
      ]),
    );
  }
}
