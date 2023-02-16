import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/styles/screen_adaption.dart';

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
    title: Hero(
      tag: title,
      child: Text(
        title,
        style: TextStyle(color: color, fontSize: 22.w),
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
            icon: Icon(Icons.arrow_back, size: 24.w),
          )
        : const SizedBox.shrink(),
    actions: actions,
  );
}
