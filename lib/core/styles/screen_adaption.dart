import 'dart:math';

import 'package:flutter/material.dart';
import 'package:object_note/core/app/global.dart';
import 'package:object_note/core/styles/theme.dart';
import 'package:object_note/core/utils/log_util.dart';

class ScreenAdaption {
  static final ScreenAdaption _instance = ScreenAdaption._init();

  factory ScreenAdaption() => _instance;

  double _scaleWidth = 1.0;
  double _scaleHeight = 1.0;

  ScreenAdaption._init() {
    Log.d('ScreenAdaptionUtil init');
    Size size = MediaQuery.of(Global.context).size;
    _scaleWidth = min(size.width, size.height) / Themes.designSize.width;
    _scaleHeight = max(size.width, size.height) / Themes.designSize.height;
  }

  scaleWidth(num a) => a * _scaleWidth;

  scaleHeight(num a) => a * _scaleHeight;
}

extension ScreenAdaptionExtension on num {
  double get w => ScreenAdaption().scaleWidth(this);

  double get h => ScreenAdaption().scaleHeight(this);
}
