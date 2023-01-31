import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslationStrings extends Translations {
  static const supportLocale = [
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
    Locale('en'),
    Locale('de'),
    Locale('fr'),
    Locale('ja'),
    Locale('ko'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'zh_Hans': {
          //Home page Tabs
          'Home': '主页',
          'Mine': '我的',
          //Guide page
          'Start Note': '开启笔记',
          'Settings': '设置',
          'Theme': '主题',
          'System': '系统',
          'Light': '浅色',
          'Dark': '深色',
          'Language': '语言',
        },
        'en': {
          //Home page Tabs
          'Home': 'Home',
          'Mine': 'Mine',
          //Guide page
          'Start Note': 'Start Note',
          'Settings': 'Settings',
          'Theme': 'Theme',
          'System': 'System',
          'Light': 'Light',
          'Dark': 'Dark',
          'Language': 'Language',
        },
      };
}
