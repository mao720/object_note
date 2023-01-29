import 'package:get/get.dart';

class TranslationStrings extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'Start Note': 'Start Note',
          'Settings': 'Settings',
          'Theme': 'Theme',
          'System': 'System',
          'Light': 'Light',
          'Dark': 'Dark',
          'Language': 'Language',
        },
        'zh_CN': {
          'Start Note': '开启笔记',
          'Settings': '设置',
          'Theme': '主题',
          'System': '系统',
          'Light': '亮色',
          'Dark': '暗色',
          'Language': '语言',
        }
      };
}
