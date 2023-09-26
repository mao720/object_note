import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/app/global.dart';

import 'mine_logic.dart';

class MineView extends StatelessWidget {
  MineView({Key? key}) : super(key: key);

  final logic = Get.put(MineLogic());
  final state = Get.find<MineLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: logic.onUserHeaderPressed,
                    child: Obx(() {
                      return Hero(
                        tag: Global.rxUser.value.objectId == null
                            ? 'login'.tr
                            : 'profile_hero',
                        child: CircleAvatar(
                          foregroundImage:
                              NetworkImage(Global.rxUser.value.avatar ?? ''),
                          radius: 36,
                          child: const Icon(Icons.account_circle, size: 72),
                        ),
                      );
                    }),
                  ),
                  Hero(
                    tag: 'Settings'.tr,
                    child: Builder(builder: (context) {
                      return IconButton(
                        color: context.theme.colorScheme.onPrimaryContainer,
                        onPressed: logic.onSettingButtonPressed,
                        icon: const Icon(Icons.settings, size: 24),
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(children: [
                ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  onTap: () => logic.onListTilePressed('Splash Page'),
                  title: Text(
                    'Splash Page'.tr,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                const Divider(),
                ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  onTap: () => logic.onListTilePressed('Guide Page'),
                  title: Text(
                    'Guide Page'.tr,
                    style: const TextStyle(fontSize: 14),
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
