import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:get/get.dart';

import '../../core/app_config.dart';
import '../../l10n/translations.dart';
import '../../widgets/base_app_bar.dart';
import 'settings_logic.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final logic = Get.put(SettingsLogic());
  final state = Get.find<SettingsLogic>().state;

  @override
  Widget build(BuildContext context) {
    var deviceLocaleName = LocaleNamesLocalizationsDelegate
        .nativeLocaleNames[Get.deviceLocale.toString()];
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: createBaseAppBar(title: 'Settings'.tr),
      body: ListView(children: [
        _createSettingCard(
          context,
          title: 'Theme'.tr,
          items: [
            _createItem(context, 'System'.tr, ThemeMode.system,
                AppConfig.themeMode, logic.onThemeChanged),
            _createItem(context, 'Light'.tr, ThemeMode.light,
                AppConfig.themeMode, logic.onThemeChanged),
            _createItem(context, 'Dark'.tr, ThemeMode.dark, AppConfig.themeMode,
                logic.onThemeChanged),
          ],
        ),
        _createSettingCard(context, title: 'Language'.tr, items: [
          _createItem(context, '${'System'.tr} - $deviceLocaleName', 'system',
              AppConfig.locale, logic.onLanguageChanged),
          ...TranslationStrings.supportLocale
              .map((local) => _createItem(
                    context,
                    LocaleNamesLocalizationsDelegate
                        .nativeLocaleNames[local.toString()],
                    local.toString(),
                    AppConfig.locale,
                    logic.onLanguageChanged,
                    subtitle: LocaleNames.of(context)?.nameOf(local.toString()),
                  ))
              .toList()
        ]),
      ]),
    );
  }

  Widget _createSettingCard(BuildContext context,
      {required String title, required List<Widget> items}) {
    return Card(
      margin: const EdgeInsets.all(ThemeConfig.paddingMedium),
      child: Padding(
        padding: const EdgeInsets.all(ThemeConfig.paddingSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: ThemeConfig.paddingSmall),
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
            const EdgeInsets.symmetric(horizontal: ThemeConfig.paddingSmall),
        dense: true,
        activeColor: Theme.of(context).colorScheme.primary,
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
