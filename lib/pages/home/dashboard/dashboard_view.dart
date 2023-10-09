import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/app/global.dart';
import 'package:object_note/pages/home/dashboard/dashboard_logic.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  final logic = Get.put(DashboardLogic());
  final state = Get.find<DashboardLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!Global.isLogin()) {
        return Center(
          child: TextButton(
            onPressed: logic.onLoginTap,
            child: Text('Please login'.tr),
          ),
        );
      } else {
        return Column(
          children: [
            Expanded(child: Text('Dashboard'.tr)),
          ],
        );
      }
    });
  }
}
