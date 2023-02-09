import 'dart:math';

import 'package:flutter/material.dart';
import 'package:object_note/utils/log_util.dart';

class ScreenAdaptionUtil {
  static const Size _designSize = Size(360, 690);
  static double _scaleWidth = 1.0;
  static double _scaleHeight = 1.0;

  static ScreenAdaptionUtil? _instance;

  factory ScreenAdaptionUtil.init(BuildContext context) {
    _instance ??= ScreenAdaptionUtil._(context);
    return _instance!;
  }

  ScreenAdaptionUtil._(BuildContext context) {
    Log.d('ScreenAdaptionUtil init()');
    Size size = MediaQuery.of(context).size;
    _scaleWidth = min(size.width, size.height) / _designSize.width;
    _scaleHeight = max(size.width, size.height) / _designSize.height;
  }

  static scaleWidth(num a) => a * _scaleWidth;

  static scaleHeight(num a) => a * _scaleHeight;
}

extension ScreenAdaptionExtension on num {
  double get w => ScreenAdaptionUtil.scaleWidth(this);

  double get h => ScreenAdaptionUtil.scaleHeight(this);
}
