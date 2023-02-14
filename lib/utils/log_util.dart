import 'dart:developer';

class Log {
  Log._();

  static const Function(Object) _print = print;

  static void d(Object value, {String? tag}) {
    log(value.toString(), name: 'ObjectNote${tag == null ? '' : (':$tag')}');
  }

  static void e(Object value, {String? tag}) {
    _print('[ObjectNote${tag == null ? ']' : (':$tag]')}${value.toString()}');
  }
}
