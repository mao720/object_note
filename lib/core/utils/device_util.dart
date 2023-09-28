import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceUtil {
  static Future<String> getDeviceName() async {
    var deviceInfoPlugin = DeviceInfoPlugin();
    if (kIsWeb) {
      return (await deviceInfoPlugin.webBrowserInfo).userAgent ?? '';
    }
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => (await deviceInfoPlugin.androidInfo).model,
      TargetPlatform.iOS => (await deviceInfoPlugin.iosInfo).utsname.machine,
      TargetPlatform.macOS => (await deviceInfoPlugin.macOsInfo).model,
      TargetPlatform.windows =>
        (await deviceInfoPlugin.windowsInfo).productName,
      TargetPlatform.linux => (await deviceInfoPlugin.linuxInfo).prettyName,
      TargetPlatform.fuchsia => 'Fuchsia',
    };
  }
}
