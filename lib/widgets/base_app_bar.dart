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
          icon: const Icon(Icons.menu, size: 24),
        ),
      ),
    );
  }
  return AppBar(
    title: Hero(
      tag: title,
      child: Text(
        title,
        style: TextStyle(color: color, fontSize: 22),
        overflow: TextOverflow.visible,
        softWrap: false,
      ),
    ),
    centerTitle: true,
    leading: showLeading
        ? IconButton(
            onPressed: () => Get.back(),
            color: color,
            tooltip: '',
            icon: const Icon(Icons.arrow_back, size: 24),
          )
        : const SizedBox.shrink(),
    actions: actions,
  );
}
