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
        padding: const EdgeInsets.only(left: 50, right: 50, bottom: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => state.username.value = value,
              decoration: InputDecoration(
                labelText: 'username'.tr,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'password'.tr,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) => state.password.value = value,
            ),
            const SizedBox(height: 20),
            TextButton(onPressed: logic.onLogin, child: Text('login'.tr)),
          ],
        ),
      ),
    );
  }
}
