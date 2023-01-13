import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'settings_logic.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final logic = Get.put(SettingsLogic());
  final state = Get.find<SettingsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
