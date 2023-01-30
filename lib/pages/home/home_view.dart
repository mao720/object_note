import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_logic.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.put(HomeLogic());
  final state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
                    child: Text('Settings'.tr),
                  )
                ],
              ),
            ],
          ),
        ),
        Obx(() {
          return NavigationBar(
            selectedIndex: state.currentIndex.value,
            destinations: state.bottomTabItems.value
                .map((item) => NavigationDestination(
                      label: item[0],
                      tooltip: '',
                      selectedIcon: Icon(item[1]),
                      icon: Icon(item[2]),
                    ))
                .toList(),
            onDestinationSelected: logic.onDestinationSelected,
          );
        }),
      ]),
    );
  }
}
