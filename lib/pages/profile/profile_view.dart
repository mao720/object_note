import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/app/global.dart';
import 'package:object_note/core/styles/screen_adaption.dart';
import 'package:object_note/pages/profile/profile_logic.dart';
import 'package:object_note/widgets/base_app_bar.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final logic = Get.put(ProfileLogic());
  final state = Get.find<ProfileLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createBaseAppBar(title: 'profile'.tr),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50.w),
          GestureDetector(
            onTap: logic.onAvatarTaped,
            child: Hero(
              tag: 'profile_hero',
              child: Obx(() {
                return CircleAvatar(
                  foregroundImage:
                      NetworkImage(Global.user.value?.avatar ?? ''),
                  radius: 36.w,
                );
              }),
            ),
          ),
          SizedBox(width: double.infinity, height: 200.w),
          TextButton(
            onPressed: logic.onLogoutPressed,
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
