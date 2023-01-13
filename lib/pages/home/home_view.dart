import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            onPageChanged: logic.onPageChanged,
            children: [
              Container(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: logic.onButtonPressed,
                    child: const Text('Setting'),
                  )
                ],
              ),
            ],
          ),
        ),
        Obx(() {
          return HomeTabView(
            currentIndex: state.currentIndex.value,
            tabItems: state.bottomTabItems.value,
            onTap: logic.onBottomItemTaped,
          );
        }),
      ]),
    );
  }
}
