import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Get.lazyPut<ThemeController>(() => ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromPreferences();
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        brightness: Brightness.light,
        fontFamily: 'LXGWWenKaiLite',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'LXGWWenKaiLite',
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class Controller extends GetxController {
  var count = 0.obs;
}

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  var themeMode = ThemeMode.system.obs;

  Future<void> setThemeMode(ThemeMode themeMode) async {
    Get.changeThemeMode(themeMode);
    this.themeMode(themeMode);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', describeEnum(themeMode));
  }

  getThemeModeFromPreferences() async {
    ThemeMode themeMode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String themeText = prefs.getString('theme') ?? 'system';
    try {
      themeMode =
          ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
    } catch (e) {
      themeMode = ThemeMode.system;
    }
    setThemeMode(themeMode);
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    final Controller c = Get.put(Controller());
    ThemeController themeController = ThemeController.to;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
                  '${c.count}',
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
        onPressed: () => c.count++,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
