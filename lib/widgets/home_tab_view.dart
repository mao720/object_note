import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeTabView extends StatefulWidget {
  final Color? selectedColor = Get.theme.colorScheme.primary;
  final Color unselectedColor = Get.theme.colorScheme.outline.withOpacity(0.3);

  HomeTabView({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeTabViewState();
  }
}

class HomeTabViewState extends State<HomeTabView> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu, color: widget.selectedColor)),
      IconButton(
          onPressed: () {},
          icon: Icon(Icons.man, color: widget.unselectedColor))
    ]);
  }
}
