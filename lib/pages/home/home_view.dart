import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/pages/home/dashboard/dashboard_view.dart';
import 'package:object_note/pages/home/home_logic.dart';
import 'package:object_note/pages/home/main/main_view.dart';
import 'package:object_note/pages/home/mine/mine_view.dart';
import 'package:object_note/widgets/keep_alive_wrapper.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.put(HomeLogic());
  final state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: logic.pageController,
          onPageChanged: logic.onPageChanged,
          children: [
            KeepAliveWrapper(child: MainView()),
            KeepAliveWrapper(child: DashboardView()),
            KeepAliveWrapper(child: MineView()),
          ],
        ),
      ),
      bottomNavigationBar: _navigationView(context),
    );
  }

  Widget _navigationView(BuildContext context) {
    return Obx(() {
      return NavigationBar(
        selectedIndex: state.currentIndex.value,
        destinations: state.bottomTabItems.value
            .map((item) => NavigationDestination(
                  label: item[0].toString().tr,
                  tooltip: '',
                  selectedIcon: Icon(item[1], size: 24),
                  icon: Icon(item[2], size: 24),
                ))
            .toList(),
        onDestinationSelected: logic.onDestinationSelected,
      );
    });
  }
}
