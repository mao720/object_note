import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:get/get.dart';
import 'package:object_note/core/styles/theme.dart';
import 'package:object_note/core/styles/translation.dart';
import 'package:object_note/pages/settings/settings_logic.dart';
import 'package:object_note/widgets/base_app_bar.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final logic = Get.put(SettingsLogic());
  final state = Get.find<SettingsLogic>().state;

  @override
  Widget build(BuildContext context) {
    var deviceLocaleName = LocaleNamesLocalizationsDelegate
        .nativeLocaleNames[Get.deviceLocale.toString()];
    var deviceBrightness = ' - '
        '${(describeEnum(MediaQuery.of(context).platformBrightness).capitalize ?? '').tr}';
    return Scaffold(
      appBar: createBaseAppBar(title: 'Settings'.tr),
      body: ListView(children: [
        _createSettingCard(context, title: 'Theme'.tr, items: [
          _createItem(context, 'System'.tr + deviceBrightness, ThemeMode.system,
              Themes.rxThemeMode, logic.onThemeChanged),
          _createItem(context, 'Light'.tr, ThemeMode.light, Themes.rxThemeMode,
              logic.onThemeChanged),
          _createItem(context, 'Dark'.tr, ThemeMode.dark, Themes.rxThemeMode,
              logic.onThemeChanged),
        ]),
        _createSettingCard(context, title: 'Language'.tr, items: [
          _createItem(context, '${'System'.tr} - $deviceLocaleName', null,
              Themes.rxLocale, logic.onLocaleChanged),
          ...Translation.supportLocale
              .map((local) => _createItem(
                    context,
                    LocaleNamesLocalizationsDelegate
                        .nativeLocaleNames[local.toString()],
                    local.toString(),
                    Themes.rxLocale,
                    logic.onLocaleChanged,
                    subtitle: LocaleNames.of(context)?.nameOf(local.toString()),
                  ))
              .toList()
        ]),
        const SizedBox(height: 24)
      ]),
    );
  }

  Widget _createSettingCard(BuildContext context,
      {required String title, required List<Widget> items}) {
    return Card(
      margin: const EdgeInsets.only(left: 24, top: 24, right: 24),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(title, style: const TextStyle(fontSize: 16)),
            ),
            ...items,
          ],
        ),
      ),
    );
  }

  Widget _createItem<T>(BuildContext context, String? title, T value,
      Rx<T?> groupValue, void Function(T value) onChanged,
      {String? subtitle}) {
    return Obx(() {
      return RadioListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        dense: true,
        controlAffinity: ListTileControlAffinity.trailing,
        title: Text(title ?? '', style: const TextStyle(fontSize: 14)),
        subtitle: Text(subtitle ?? '', style: const TextStyle(fontSize: 12)),
        value: value,
        groupValue: groupValue.value,
        onChanged: (v) => onChanged(value),
      );
    });
  }
}
