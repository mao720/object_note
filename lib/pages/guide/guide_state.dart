import 'package:get/get.dart';
import 'package:object_note/core/assets.dart';

class GuideState {
  var guideIllustrations = [
    Assets.illustrationStayAtHome,
    Assets.illustrationBook,
    // Assets.illustrationBookshelf,
    Assets.illustrationHeart,
    // Assets.illustrationPlantingTrees,
    // Assets.illustrationWalking,
    Assets.illustrationWateringFlowers,
  ];
  var currentPageIndex = 0.obs;

  GuideState() {
    ///Initialize variables
  }
}
