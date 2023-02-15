import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/utils/screen_adaption_util.dart';

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
          icon: Icon(Icons.menu, size: 24.w),
        ),
      ),
    );
  }
  return AppBar(
    title: Text(title, style: TextStyle(color: color, fontSize: 22.w)),
    centerTitle: true,
    leading: showLeading
        ? Hero(
            tag: title,
            child: IconButton(
              onPressed: () => Get.back(),
              color: color,
              tooltip: '',
              icon: Icon(Icons.arrow_back, size: 24.w),
            ),
          )
        : const SizedBox.shrink(),
    actions: actions,
  );
}
