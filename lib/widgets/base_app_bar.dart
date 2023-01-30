import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget createBaseAppBar({
  String title = 'AppBar',
  bool showLeading = true,
  Color? color,
  Function()? onMenuPressed,
}) {
  List<Widget> actions = [];
  if (onMenuPressed != null) {
    actions.add(
      SizedBox(
        width: kToolbarHeight,
        child: IconButton(
          onPressed: onMenuPressed,
          tooltip: 'menu',
          color: color,
          icon: const Icon(Icons.menu),
        ),
      ),
    );
  }
  return AppBar(
    title: Text(title, style: TextStyle(color: color)),
    centerTitle: true,
    leading: showLeading
        ? IconButton(
            onPressed: () => Get.back(),
            color: color,
            icon: const Icon(Icons.arrow_back),
          )
        : null,
    actions: actions,
  );
}
