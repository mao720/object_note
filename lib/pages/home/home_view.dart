import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_config.dart';
import 'home_logic.dart';

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
      padding: const EdgeInsets.all(ThemeConfig.paddingEESmall),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(ThemeConfig.paddingEMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.account_circle,
                      size: ThemeConfig.iconXMedium,
                    ),
                  ),
                  Hero(
                    tag: 'Settings'.tr,
                    child: IconButton(
                      onPressed: logic.onSettingButtonPressed,
                      icon: const Icon(Icons.settings,
                          size: ThemeConfig.iconESmall),
                    ),
                  )
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(ThemeConfig.paddingESmall),
              child: Column(children: [
                ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: ThemeConfig.paddingMedium),
                  onTap: () => logic.onListTilePressed('Splash Page'),
                  title: Text('Splash Page'.tr,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                const Divider(),
                ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: ThemeConfig.paddingMedium),
                  onTap: () => logic.onListTilePressed('Guide Page'),
                  title: Text('Guide Page'.tr,
                      style: Theme.of(context).textTheme.bodyMedium),
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
                  selectedIcon: Icon(item[1], size: ThemeConfig.iconESmall),
                  icon: Icon(item[2], size: ThemeConfig.iconESmall),
                ))
            .toList(),
        onDestinationSelected: logic.onDestinationSelected,
      );
    });
  }
}
