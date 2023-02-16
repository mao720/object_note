import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/pages/login/login_logic.dart';
import 'package:object_note/widgets/base_app_bar.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final logic = Get.put(LoginLogic());
  final state = Get.find<LoginLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createBaseAppBar(title: 'login'.tr),
      body: Container(
        child: Column(
          children: [
            TextField(
              onChanged: (value) => state.username.value = value,
            ),
            TextField(
              onChanged: (value) => state.password.value = value,
            ),
            TextButton(onPressed: logic.onLogin, child: const Text('login'))
          ],
        ),
      ),
    );
  }
}
