import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/widgets/home_tab_view.dart';

import 'home_logic.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.put(HomeLogic());
  final state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: PageController(initialPage: 1),
            children: [
              Container(),
              Container(),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: HomeTabView(),
          )
        ],
      ),
    );
  }
}
