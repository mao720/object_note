import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/widgets/base_app_bar.dart';

import 'profile_logic.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final logic = Get.put(ProfileLogic());
  final state = Get.find<ProfileLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createBaseAppBar(title: 'profile'.tr),
      body: Container(
        alignment: Alignment.center,
        child: TextButton(
            onPressed: logic.onLogoutPressed, child: const Text('Logout')),
      ),
    );
  }
}
