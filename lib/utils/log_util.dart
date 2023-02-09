import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class Log {
  Log._();

  static void d(String value, {bool isError = false}) {
    if (isError || kDebugMode) developer.log(value, name: 'ObjectNote');
  }
}
