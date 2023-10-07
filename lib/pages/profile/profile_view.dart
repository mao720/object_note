import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/app/global.dart';
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
          const SizedBox(height: 50),
          GestureDetector(
            onTap: logic.onAvatarTaped,
            child: Hero(
              tag: 'profile_hero',
              child: Obx(() {
                var avatarUrl = Global.rxUser.value.avatar;
                return CircleAvatar(
                  foregroundImage:
                      avatarUrl == null ? null : NetworkImage(avatarUrl),
                  radius: 36,
                );
              }),
            ),
          ),
          const SizedBox(width: double.infinity, height: 200),
          TextButton(
            onPressed: logic.onLogoutPressed,
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
