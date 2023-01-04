import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import 'test_logic.dart';

class TestPage extends StatelessWidget {
  TestPage({Key? key}) : super(key: key);

  final logic = Get.put(TestLogic());

  @override
  Widget build(BuildContext context) {
    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    ThemeController themeController = ThemeController.to;
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
                  title: const Text('system'),
                  value: ThemeMode.system,
                  groupValue: themeController.themeMode.value,
                  onChanged: (value) {
                    themeController.setThemeMode(ThemeMode.system);
                  },
                ),
                RadioListTile(
                  title: const Text('dark'),
                  value: ThemeMode.dark,
                  groupValue: themeController.themeMode.value,
                  onChanged: (value) {
                    themeController.setThemeMode(ThemeMode.dark);
                  },
                ),
                RadioListTile(
                  title: const Text('light'),
                  value: ThemeMode.light,
                  groupValue: themeController.themeMode.value,
                  onChanged: (value) async {
                    themeController.setThemeMode(ThemeMode.light);
                    Get.snackbar('title', 'snackBar');
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
