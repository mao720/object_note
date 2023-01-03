import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/common/config.dart';

import 'splash_logic.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  final logic = Get.put(SplashLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: TextButton(
        style: const ButtonStyle(),
        onPressed: () => Get.toNamed(RouteGet.testPage),
        child: const Text('打开即可'),
      ),
    ));
  }
}
