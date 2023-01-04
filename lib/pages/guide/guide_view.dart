import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'guide_logic.dart';

class GuidePage extends StatelessWidget {
  GuidePage({Key? key}) : super(key: key);

  final logic = Get.put(GuideLogic());

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
