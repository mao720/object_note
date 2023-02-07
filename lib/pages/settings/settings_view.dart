import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:get/get.dart';
import 'package:object_note/core/styles.dart';
import 'package:object_note/l10n/translation.dart';
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
    var deviceBrightness =
        ' - ${(describeEnum(MediaQuery.of(context).platformBrightness).capitalize ?? '').tr}';
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
              Styles.locale, logic.onLanguageChanged),
          ...Translation.supportLocale
              .map((local) => _createItem(
                    context,
                    LocaleNamesLocalizationsDelegate
                        .nativeLocaleNames[local.toString()],
                    local.toString(),
                    Styles.locale,
                    logic.onLanguageChanged,
                    subtitle: LocaleNames.of(context)?.nameOf(local.toString()),
                  ))
              .toList()
        ]),
        const SizedBox(height: Styles.paddingMedium)
      ]),
    );
  }

  Widget _createSettingCard(BuildContext context,
      {required String title, required List<Widget> items}) {
    return Card(
      margin: const EdgeInsets.only(
          left: Styles.paddingMedium,
          top: Styles.paddingMedium,
          right: Styles.paddingMedium),
      child: Padding(
        padding: const EdgeInsets.all(Styles.paddingSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: Styles.paddingSmall),
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.apply(color: Theme.of(context).colorScheme.secondary),
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: Styles.paddingSmall),
        dense: true,
        controlAffinity: ListTileControlAffinity.trailing,
        title: Text(title ?? '', style: Theme.of(context).textTheme.bodyMedium),
        subtitle: subtitle == null
            ? null
            : Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
        value: value,
        groupValue: groupValue.value,
        onChanged: (v) => onChanged(value),
      );
    });
  }
}
