import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:object_note/core/app/global.dart';
import 'package:object_note/core/http/api.dart';
import 'package:object_note/core/utils/constants.dart';
import 'package:object_note/modal/user.dart';
import 'package:object_note/widgets/toast.dart';

import 'profile_state.dart';

class ProfileLogic extends GetxController {
  final ProfileState state = ProfileState();

  onLogoutPressed() async {
    await Api.logout();
    Global.setUser(User());
    Toast.success(text: 'Logout Success'.tr);
    await Future.delayed(const Duration(milliseconds: 500));
    Get.back();
  }

  onAvatarTaped() async {
    Toast.loading();
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    // Capture a photo
    // final XFile? image = await picker.pickImage(source: ImageSource.camera);
    Toast.dismiss();
    if (image != null) {
      if (kIsWeb) {
        var intList = (await image.readAsBytes()).toList();
        await Api.uploadToOSSWeb(intList, image.name);
      } else {
        await Api.uploadToOSS(image.path, image.name);
      }
      updateUserAvatar(
          Constants.ossDomain + Constants.ossDirImage + image.name);
    }
  }

  updateUserAvatar(String avatarUrl) async {
    var objectId = Global.rxUser.value.objectId;
    if (objectId != null) {
      await Api.updateUser(objectId, avatarUrl: avatarUrl);
      Toast.success(text: 'Avatar Updated'.tr);
      Global.setAvatarUrl(avatarUrl);
    }
  }
}
