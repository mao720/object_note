import 'package:get/get.dart';
import 'package:object_note/core/app/app_route.dart';

import 'mine_state.dart';

class MineLogic extends GetxController {
  final MineState state = MineState();

  onUserHeaderPressed() {
    Get.toNamed(AppRoute.profilePage);
  }

  onSettingButtonPressed() async {
    Get.toNamed(AppRoute.settingsPage);
  }

  onListTilePressed(String title) {
    switch (title) {
      case 'Splash Page':
        Get.toNamed(AppRoute.splashPage);
        break;
      case 'Guide Page':
        Get.toNamed(AppRoute.guidePage);
        break;
    }
  }
}
