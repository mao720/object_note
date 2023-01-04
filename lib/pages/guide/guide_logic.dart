import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuideLogic extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstOpen', false);
  }
}
