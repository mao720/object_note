import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class Log {
  Log._();

  static void d(Object value, {String? tag}) {
    if (kDebugMode) {
      developer.log(value.toString(),
          name: 'ObjectNote${tag == null ? '' : (':$tag')}');
    }
  }

  static void r(Object value, {String? tag}) {
    // ignore: avoid_print
    print('[ObjectNote${tag == null ? ']' : (':$tag]')}${value.toString()}');
  }
}
