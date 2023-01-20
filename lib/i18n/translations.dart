import 'package:get/get.dart';

class TranslationStrings extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'Start Note': 'Start Note',
          'Settings': 'Settings',
          'Theme': 'Theme',
          'system': 'system',
          'light': 'light',
          'dark': 'dark',
        },
        'zh_CN': {
          'Start Note': '开启笔记',
          'Settings': '设置',
          'Theme': '主题',
          'system': '系统',
          'light': '亮色',
          'dark': '暗色',
        }
      };
}
