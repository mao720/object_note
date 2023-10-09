import 'package:get/get.dart';
import 'package:object_note/core/app/app_route.dart';
import 'package:object_note/pages/home/dashboard/dashboard_state.dart';

class DashboardLogic extends GetxController {
  final DashboardState state = DashboardState();

  onLoginTap() {
    Get.toNamed(AppRoute.loginPage);
  }
}
