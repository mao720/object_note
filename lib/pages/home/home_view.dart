import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/pages/home/home_logic.dart';
import 'package:object_note/utils/screen_adaption_util.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.put(HomeLogic());
  final state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: PageView(
              controller: logic.pageController,
              onPageChanged: logic.onPageChanged,
              children: [
                Container(),
                _mineView(context),
              ],
            ),
          ),
          _navigationView(context)
        ]),
      ),
    );
  }

  Widget _mineView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: logic.onUserHeaderPressed,
                    child: Hero(
                      tag: 'login'.tr,
                      child: Icon(
                        Icons.account_circle,
                        size: 72.w,
                      ),
                    ),
                  ),
                  Hero(
                    tag: 'Settings'.tr,
                    child: IconButton(
                      onPressed: logic.onSettingButtonPressed,
                      icon: Icon(Icons.settings, size: 24.w),
                    ),
                  )
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(children: [
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
                  onTap: () => logic.onListTilePressed('Splash Page'),
                  title: Text(
                    'Splash Page'.tr,
                    style: TextStyle(fontSize: 14.w),
                  ),
                ),
                const Divider(),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
                  onTap: () => logic.onListTilePressed('Guide Page'),
                  title: Text(
                    'Guide Page'.tr,
                    style: TextStyle(fontSize: 14.w),
                  ),
                )
              ]),
            ),
          )
        ],
      ),
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
                  selectedIcon: Icon(item[1], size: 24.w),
                  icon: Icon(item[2], size: 24.w),
                ))
            .toList(),
        onDestinationSelected: logic.onDestinationSelected,
      );
    });
  }
}
