import 'package:get/get.dart';
import 'package:object_note/core/app/app_route.dart';
import 'package:object_note/core/http/api.dart';
import 'package:object_note/pages/home/dashboard/dashboard_state.dart';

class DashboardLogic extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    onRefresh();
  }

  final DashboardState state = DashboardState();

  Future<void> onRefresh() async {
    var listNote = await Api.getNotes();
    state.rxListNote.value = listNote;
    state.rxCurrentNote.value = listNote.firstOrNull;
    state.rxListLabel.value = await Api.getLabels();
  }

  onLoginTap() {
    Get.toNamed(AppRoute.loginPage);
  }
}
