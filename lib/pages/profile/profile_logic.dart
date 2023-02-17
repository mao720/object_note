import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:object_note/core/app/global.dart';
import 'package:object_note/core/http/api.dart';
import 'package:object_note/core/utils/constants.dart';
import 'package:object_note/core/utils/log_util.dart';
import 'package:object_note/modal/user.dart';
import 'package:object_note/widgets/toast.dart';

import 'profile_state.dart';

class ProfileLogic extends GetxController {
  final ProfileState state = ProfileState();

  void onLogoutPressed() async {
    await Api.logout();
    Global.setUser(null);
    Toast.success(text: 'Logout'.tr);
    await Future.delayed(const Duration(milliseconds: 500));
    Get.back();
  }

  void onAvatarTaped() async {
    Toast.loading();
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    // Capture a photo
    // final XFile? image = await picker.pickImage(source: ImageSource.camera);
    Toast.dismiss();
    if (image != null) {
      var response = await Api.uploadToOSS(File(image.path), image.name);
      Log.d(response);
      updateUserAvatar(
          Constants.ossDomain + Constants.ossDirImage + image.name);
    }
  }

  void updateUserAvatar(String avatarUrl) async {
    var user = Global.user.value;
    if (user != null && user.objectId != null) {
      await Api.updateUser(user.objectId!, avatarUrl: avatarUrl);
      Toast.success(text: 'Avatar Updated'.tr);
      user.avatar = avatarUrl;
      Global.setUser(User.fromJson(user.toJson()));
    }
  }
}
