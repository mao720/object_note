import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:object_note/pages/guide/guide_logic.dart';

class GuidePage extends StatelessWidget {
  GuidePage({Key? key}) : super(key: key);

  final logic = Get.put(GuideLogic());
  final state = Get.find<GuideLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          onPageChanged: (index) => state.currentPageIndex.value = index,
          controller: logic.pageController,
          children: state.guideIllustrations
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
                      state.guideIllustrations.length - 1
                  ? MaterialButton(
                      color: context.theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      onPressed: logic.onButtonPressed,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Start Note'.tr,
                          style: TextStyle(
                            fontSize: 22,
                            color: context.theme.colorScheme.onPrimary,
                          ),
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
        children: state.guideIllustrations
            .asMap()
            .keys
            .map((index) => Obx(() {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: state.currentPageIndex.value == index
                          ? context.theme.colorScheme.primary
                          : context.theme.colorScheme.primaryContainer,
                    ),
                  );
                }))
            .toList());
  }
}
