import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:object_note/core/styles/screen_adaption.dart';
import 'package:object_note/core/styles/theme.dart';
import 'package:object_note/core/utils/log_util.dart';

class Toast {
  Toast.init() {
    Log.d('Toast init');
    EasyLoading.instance
      ..userInteractions = true
      ..dismissOnTap = false
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Themes.cs.surface
      ..progressColor = Themes.cs.onSurface
      ..indicatorColor = Themes.cs.onSurface
      ..textColor = Themes.cs.onSurface
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorSize = 45.w
      ..radius = 10.w
      ..boxShadow = [
        BoxShadow(
            color: Themes.cs.onSurface,
            blurRadius: 6.w,
            blurStyle: BlurStyle.solid)
      ];
  }

  static bool get isShow => EasyLoading.isShow;

  static show(String toast) {
    EasyLoading.showToast(toast);
  }

  static loading() {
    EasyLoading.show(status: 'loading'.tr);
  }

  static progress(double value, {String? text}) {
    //pull request #186
    //progress.dart: _value = widget.value;
    EasyLoading.showProgress(value, status: text);
  }

  static info(String text) {
    EasyLoading.showInfo(text);
  }

  static success({String? text}) {
    EasyLoading.showSuccess(text ?? 'success'.tr);
  }

  static error(String text) {
    EasyLoading.showError(text);
  }

  static dismiss() {
    EasyLoading.dismiss(animation: true);
  }
}
