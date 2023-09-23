import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Translation extends Translations {
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
        'zh_Hans': zhHans,
        'en': en,
      };

  final Map<String, String> zhHans = {
    // APP
    'Object Note': '对象笔记',
    // Home page Tabs
    'Home': '主页',
    'Mine': '我的',
    // Mine Tab
    'Splash Page': '启动页',
    'Guide Page': '导航页',
    // Guide page
    'Start Note': '开启笔记',
    // Settings page
    'Settings': '设置',
    'Theme': '主题',
    'System': '系统',
    'Light': '浅色',
    'Dark': '深色',
    'Language': '语言',
    'Login Success': '登录成功',
    'Logout Success': '注销成功',
  };

  final Map<String, String> en = {
    // APP
    'Object Note': 'Object Note',
    // Home page Tabs
    'Home': 'Home',
    'Mine': 'Mine',
    // Mine tab
    'Splash Page': 'Splash Page',
    'Guide Page': 'Guide Page',
    // Guide page
    'Start Note': 'Start Note',
    // Settings page
    'Settings': 'Settings',
    'Theme': 'Theme',
    'System': 'System',
    'Light': 'Light',
    'Dark': 'Dark',
    'Language': 'Language',
    'Login Success': 'Login Success',
    'Logout Success': 'Logout Success',
  };
}
