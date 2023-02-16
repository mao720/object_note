import 'package:get/get.dart';
import 'package:object_note/core/app/global.dart';
import 'package:object_note/core/http/api.dart';
import 'package:object_note/modal/user.dart';
import 'package:object_note/widgets/toast.dart';

import 'login_state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();

  void onLogin() async {
    User user = await Api.login(state.username.value, state.password.value);
    Global.setUser(user);
    Toast.success(text: 'Login'.tr);
    await Future.delayed(const Duration(milliseconds: 500));
    Get.back();
  }
}
