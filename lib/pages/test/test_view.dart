import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_controller.dart';
import 'test_logic.dart';

class TestPage extends StatelessWidget {
  TestPage({Key? key}) : super(key: key);

  final logic = Get.put(TestLogic());

  @override
  Widget build(BuildContext context) {
    AppController themeController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  'You have pushed the button this many times:',
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                Text(
                  '${logic.count}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Center(
                  child: Text(
                    'System Brightness: ${Get.mediaQuery.platformBrightness.toString()}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    'Theme Brightness: ${Get.theme.brightness.toString()}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'ThemeMode',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.left,
                ),
                RadioListTile(
                  activeColor: Get.theme.colorScheme.primary,
                  title: const Text('system'),
                  value: ThemeMode.system,
                  groupValue: themeController.themeMode.value,
                  onChanged: (value) {
                    themeController.setThemeMode(ThemeMode.system);
                  },
                ),
                RadioListTile(
                  activeColor: Get.theme.colorScheme.primary,
                  title: const Text('dark'),
                  value: ThemeMode.dark,
                  groupValue: themeController.themeMode.value,
                  onChanged: (value) {
                    themeController.setThemeMode(ThemeMode.dark);
                    Get.snackbar('title', '啥境界解决');
                  },
                ),
                RadioListTile(
                  activeColor: Get.theme.colorScheme.primary,
                  title: const Text('light'),
                  value: ThemeMode.light,
                  groupValue: themeController.themeMode.value,
                  onChanged: (value) async {
                    themeController.setThemeMode(ThemeMode.light);
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('的看法控件')),
                    // );
                    Get.snackbar('title', '啥境界解决');
                  },
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => logic.count++,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
