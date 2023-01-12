import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/config.dart';
import 'package:object_note/widgets/home_tab_view.dart';

import 'home_logic.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.put(HomeLogic());
  final state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: PageView(
            controller: logic.pageController,
            onPageChanged: (index) => logic.currentIndex.value = index,
            children: [
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () => Get.toNamed(RouteGet.testPage),
                  child: const Text('test'),
                ),
              ),
              Container(),
            ],
          ),
        ),
        Obx(() {
          return HomeTabView(
            currentIndex: logic.currentIndex.value,
            onTap: (index) {
              logic.currentIndex.value = index;
              logic.pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
          );
        }),
      ]),
    );
  }
}
