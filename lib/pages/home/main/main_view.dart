import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/app/global.dart';

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
        return Global.rxUser.value.objectId == null
            ? const Text('未登录')
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...state.listLabel
                      .map((label) => Container(
                            color: Colors.green,
                            child: Text('${label.name}'),
                          ))
                      .toList(),
                  FloatingActionButton(
                    onPressed: logic.createLabel,
                    child: const Icon(Icons.add),
                  )
                ],
              );
      }),
    );
  }
}
