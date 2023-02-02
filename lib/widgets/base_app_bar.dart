import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/app_config.dart';

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
          icon: const Icon(Icons.menu, size: ThemeConfig.iconESmall),
        ),
      ),
    );
  }
  return AppBar(
    title: Text(title, style: TextStyle(color: color)),
    centerTitle: true,
    leading: showLeading
        ? Hero(
            tag: title,
            child: IconButton(
              onPressed: () => Get.back(),
              color: color,
              tooltip: '',
              icon: const Icon(Icons.arrow_back, size: ThemeConfig.iconESmall),
            ),
          )
        : const SizedBox.shrink(),
    actions: actions,
  );
}
