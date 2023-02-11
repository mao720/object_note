import 'dart:math';

import 'package:flutter/material.dart';
import 'package:object_note/core/global.dart';
import 'package:object_note/core/styles.dart';
import 'package:object_note/utils/log_util.dart';

class ScreenAdaptionUtil {
  static final ScreenAdaptionUtil _instance = ScreenAdaptionUtil._init();

  factory ScreenAdaptionUtil() => _instance;

  double _scaleWidth = 1.0;
  double _scaleHeight = 1.0;

  ScreenAdaptionUtil._init() {
    Log.d('ScreenAdaptionUtil init');
    Size size = MediaQuery.of(Global.context).size;
    _scaleWidth = min(size.width, size.height) / Styles.designSize.width;
    _scaleHeight = max(size.width, size.height) / Styles.designSize.height;
  }

  scaleWidth(num a) => a * _scaleWidth;

  scaleHeight(num a) => a * _scaleHeight;
}

extension ScreenAdaptionExtension on num {
  double get w => ScreenAdaptionUtil().scaleWidth(this);

  double get h => ScreenAdaptionUtil().scaleHeight(this);
}
