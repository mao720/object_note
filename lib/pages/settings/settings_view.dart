import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/widgets/base_app_bar.dart';

import 'settings_logic.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final logic = Get.put(SettingsLogic());
  final state = Get.find<SettingsLogic>().state;

  Widget _createThemeSetting(BuildContext context) {
    Widget createItem(String title, ThemeMode themeMode) {
      return RadioListTile(
        activeColor: Theme.of(context).colorScheme.primary,
        title: Text(title),
        value: themeMode,
        groupValue: logic.appController.themeMode.value,
        onChanged: (value) {
          logic.appController.setThemeMode(themeMode);
        },
      );
    }

    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Theme',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.apply(color: Theme.of(context).colorScheme.secondary),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Obx(() {
                  return Column(
                    children: [
                      createItem('system', ThemeMode.system),
                      createItem('dark', ThemeMode.dark),
                      createItem('light', ThemeMode.light),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createBaseAppBar(title: 'Settings'),
        body: Column(
          children: [_createThemeSetting(context)],
        ));
  }
}
