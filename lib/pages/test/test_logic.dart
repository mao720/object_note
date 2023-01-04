import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestLogic extends GetxController {
  var count = 0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstOpen', true);
  }
}
