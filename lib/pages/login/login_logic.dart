import 'package:get/get.dart';
import 'package:object_note/core/http.dart';
import 'package:object_note/utils/log_util.dart';

import 'login_state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();

  void onLogin() async {
    Log.d(state.username.value);
    Log.d(state.password.value);
    var data = await Http().post('login', data: {
      'username': state.username.value,
      'password': state.password.value,
    });
    Log.d(data.runtimeType);
    Log.d(data.username + data.objectId);
  }
}
