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
      backgroundColor: Theme.of(context).colorScheme.background,
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
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Theme.of(context).colorScheme.primary),
                      ),
                      onPressed: logic.onButtonPressed,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: ThemeConfig.paddingEMedium),
                        child: Text(
                          'Start Note'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                    )
                  : _indicatorView(context);
            }),
          )
        ]),
      ]),
    );
  }

  Widget _indicatorView(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: AppConfig.guideIllustrations
            .asMap()
            .keys
            .map((index) => Obx(() {
                  return Container(
                    width: ThemeConfig.iconEEEESmall,
                    height: ThemeConfig.iconEEEESmall,
                    margin: const EdgeInsets.symmetric(
                        horizontal: ThemeConfig.paddingEEESmall),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: state.currentPageIndex.value == index
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onPrimary,
                    ),
                  );
                }))
            .toList());
  }
}
