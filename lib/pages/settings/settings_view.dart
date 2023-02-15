import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:get/get.dart';
import 'package:object_note/core/styles/translation.dart';
import 'package:object_note/core/styles/styles.dart';
import 'package:object_note/core/utils/screen_adaption_util.dart';
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
              Styles.themeMode, logic.onThemeChanged),
          _createItem(context, 'Light'.tr, ThemeMode.light, Styles.themeMode,
              logic.onThemeChanged),
          _createItem(context, 'Dark'.tr, ThemeMode.dark, Styles.themeMode,
              logic.onThemeChanged),
        ]),
        _createSettingCard(context, title: 'Language'.tr, items: [
          _createItem(context, '${'System'.tr} - $deviceLocaleName', 'system',
              Styles.locale, logic.onLocaleChanged),
          ...Translation.supportLocale
              .map((local) => _createItem(
                    context,
                    LocaleNamesLocalizationsDelegate
                        .nativeLocaleNames[local.toString()],
                    local.toString(),
                    Styles.locale,
                    logic.onLocaleChanged,
                    subtitle: LocaleNames.of(context)?.nameOf(local.toString()),
                  ))
              .toList()
        ]),
        SizedBox(height: 24.w)
      ]),
    );
  }

  Widget _createSettingCard(BuildContext context,
      {required String title, required List<Widget> items}) {
    return Card(
      margin: EdgeInsets.only(left: 24.w, top: 24.w, right: 24.w),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 16.w),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 16.w,
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            ...items,
          ],
        ),
      ),
    );
  }

  Widget _createItem<T>(BuildContext context, String? title, T value,
      Rx<T> groupValue, void Function(T value) onChanged,
      {String? subtitle}) {
    return Obx(() {
      return RadioListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        dense: true,
        controlAffinity: ListTileControlAffinity.trailing,
        title: Text(title ?? '', style: TextStyle(fontSize: 14.w)),
        subtitle: subtitle == null
            ? null
            : Text(subtitle, style: TextStyle(fontSize: 12.w)),
        value: value,
        groupValue: groupValue.value,
        onChanged: (v) => onChanged(value),
      );
    });
  }
}
