import 'package:flutter/foundation.dart';

class Log {
  Log._();

  static const Function(Object) _print = print;

  static void d(Object value, {String? tag}) {
    if (kDebugMode) {
      _print(
          '[ObjectNote${tag == null ? '] ' : (':$tag] ')}${value.toString()}');
    }
  }

  static void e(Object value, {String? tag}) {
    _print('[ObjectNote${tag == null ? '] ' : (':$tag] ')}${value.toString()}');
  }
}
