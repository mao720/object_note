import 'package:get/get.dart';
import 'package:object_note/core/utils/constants.dart';

class GuideState {
  var guideIllustrations = [
    Constants.illustrationStayAtHome,
    Constants.illustrationBook,
    // Assets.illustrationBookshelf,
    Constants.illustrationHeart,
    // Assets.illustrationPlantingTrees,
    // Assets.illustrationWalking,
    Constants.illustrationWateringFlowers,
  ];
  RxInt currentPageIndex = 0.obs;

  GuideState() {
    ///Initialize variables
  }
}
