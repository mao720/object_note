import 'package:get/get.dart';
import 'package:object_note/core/app/global.dart';
import 'package:object_note/core/http/api.dart';
import 'package:object_note/modal/label.dart';
import 'package:object_note/widgets/toast.dart';

import 'main_state.dart';

class MainLogic extends GetxController {
  final MainState state = MainState();
  late Worker worker;

  @override
  onInit() {
    worker = ever(Global.rxUser, (user) => getListLabel());
    getListLabel();
    super.onInit();
  }

  @override
  void onClose() {
    worker.dispose();
    super.onClose();
  }

  getListLabel() async {
    var userId = Global.rxUser.value.objectId;
    if (userId == null) return;
    var value = await Api.getLabels(userId);
    state.listLabel.value = value;
  }

  createLabel() async {
    var userId = Global.rxUser.value.objectId;
    if (userId == null) return;
    var newLabel = Label(userId: userId, name: 'name');
    bool isLabelExist = await Api.isLabelExist(newLabel);
    if (isLabelExist) {
      Toast.show('Label already exist'.tr);
      return;
    }
    await Api.createLabel(newLabel);
    getListLabel();
  }
}
