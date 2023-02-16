import 'package:get/get.dart';
import 'package:object_note/core/app/global.dart';
import 'package:object_note/core/http/api.dart';
import 'package:object_note/widgets/toast.dart';

import 'profile_state.dart';

class ProfileLogic extends GetxController {
  final ProfileState state = ProfileState();

  void onLogoutPressed() async {
    await Api.logout();
    Global.setUser(null);
    Toast.success(text: 'Logout'.tr);
    await Future.delayed(const Duration(milliseconds: 500));
    Get.back();
  }
}
