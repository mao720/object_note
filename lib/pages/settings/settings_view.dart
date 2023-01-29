import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/widgets/base_app_bar.dart';

import 'settings_logic.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final logic = Get.put(SettingsLogic());
  final state = Get.find<SettingsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createBaseAppBar(title: 'Settings'.tr),
        body: Column(
          children: [
            _createSettingCard(
              context,
              'Theme'.tr,
              [
                _createThemeItem(context, 'system'.tr, ThemeMode.system,
                    logic.appController.themeMode.value, logic.onThemeChanged),
                _createThemeItem(context, 'light'.tr, ThemeMode.light,
                    logic.appController.themeMode.value, logic.onThemeChanged),
                _createThemeItem(context, 'dark'.tr, ThemeMode.dark,
                    logic.appController.themeMode.value, logic.onThemeChanged),
              ],
            ),
            _createSettingCard(
              context,
              'language'.tr,
              [
                _createThemeItem(context, 'system'.tr, Get.deviceLocale!,
                    Get.deviceLocale!, logic.onLanguageChanged),
                _createThemeItem(context, '中文', Locale('en', 'US'),
                    Locale('en'), logic.onLanguageChanged),
                _createThemeItem(context, 'English', Locale('en', 'US'),
                    Locale('en'), logic.onLanguageChanged),
              ],
            ),
          ],
        ));
  }

  Widget _createSettingCard(
      BuildContext context, String title, List<Widget> items) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.apply(color: Theme.of(context).colorScheme.secondary),
            ),
            const SizedBox(height: 10),
            ...items,
          ],
        ),
      ),
    );
  }

  Widget _createThemeItem<T>(BuildContext context, String title, T value,
      T groupValue, void Function(T? value) onChanged) {
    return Obx(() {
      return RadioListTile(
        activeColor: Theme.of(context).colorScheme.primary,
        title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      );
    });
  }
}
