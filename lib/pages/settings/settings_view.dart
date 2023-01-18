import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/widgets/base_app_bar.dart';

import '../../core/app_controller.dart';
import 'settings_logic.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final logic = Get.put(SettingsLogic());
  final state = Get.find<SettingsLogic>().state;
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createBaseAppBar(),
      body: Card(
        margin: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Theme',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  //color: Theme.of(context).colorScheme.surface,
                  child: Column(
                    children: [
                      RadioListTile(
                        activeColor: Theme.of(context).colorScheme.primary,
                        title: const Text('system'),
                        value: ThemeMode.system,
                        groupValue: appController.themeMode.value,
                        onChanged: (value) {
                          appController.setThemeMode(ThemeMode.system);
                        },
                      ),
                      RadioListTile(
                        activeColor: Theme.of(context).colorScheme.primary,
                        title: const Text('dark'),
                        value: ThemeMode.dark,
                        groupValue: appController.themeMode.value,
                        onChanged: (value) {
                          appController.setThemeMode(ThemeMode.dark);
                        },
                      ),
                      RadioListTile(
                        activeColor: Theme.of(context).colorScheme.primary,
                        title: const Text('light'),
                        value: ThemeMode.light,
                        groupValue: appController.themeMode.value,
                        onChanged: (value) async {
                          appController.setThemeMode(ThemeMode.light);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('是大家纷纷开始搭建')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
