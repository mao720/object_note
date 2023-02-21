import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/app/global.dart';
import 'package:object_note/core/styles/screen_adaption.dart';

import 'main_logic.dart';

class MainView extends StatelessWidget {
  MainView({Key? key}) : super(key: key);

  final logic = Get.put(MainLogic());
  final state = Get.find<MainLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Obx(() {
        return Global.user.value == null
            ? const Text('未登录')
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.green,
                    child: const Text('我的'),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Colors.green,
                        child: const Text('文学'),
                      ),
                      Container(
                        color: Colors.green,
                        child: const Text('社会'),
                      ),
                    ],
                  )
                ],
              );
      }),
    );
  }
}
