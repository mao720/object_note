import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:object_note/core/styles/screen_adaption.dart';
import 'package:object_note/core/styles/theme.dart';
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
                      color: Themes.cs.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.w)),
                      onPressed: logic.onButtonPressed,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          'Start Note'.tr,
                          style: TextStyle(
                              fontSize: 22.w,
                              color: Themes.cs.primaryContainer),
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
                    width: 8.w,
                    height: 8.w,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: state.currentPageIndex.value == index
                          ? Themes.cs.primary
                          : Themes.cs.primaryContainer,
                    ),
                  );
                }))
            .toList());
  }
}
