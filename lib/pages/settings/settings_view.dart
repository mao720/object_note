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
          children: [_createThemeSetting(context),Text('语言')],
        ));
  }

  Widget _createThemeSetting(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme'.tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.apply(color: Theme.of(context).colorScheme.secondary),
            ),
            const SizedBox(height: 10),
            _createThemeItem(context, 'system'.tr, ThemeMode.system),
            _createThemeItem(context, 'light'.tr, ThemeMode.light),
            _createThemeItem(context, 'dark'.tr, ThemeMode.dark),
          ],
        ),
      ),
    );
  }

  Widget _createThemeItem(
      BuildContext context, String title, ThemeMode themeMode) {
    return Obx(() {
      return RadioListTile(
        activeColor: Theme.of(context).colorScheme.primary,
        title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
        value: themeMode,
        groupValue: logic.appController.themeMode.value,
        onChanged: (value) {
          logic.appController.setThemeMode(themeMode);
        },
      );
    });
  }
}
