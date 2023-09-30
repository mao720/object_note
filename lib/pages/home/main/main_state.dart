import 'package:get/get.dart';
import 'package:object_note/modal/label.dart';
import 'package:object_note/modal/note.dart';

class MainState {
  Rx<List<Label>> rxListLabel = Rx([]);
  Rx<List<Note>> rxListNote = Rx([]);
  RxString rxNewNoteName = ''.obs;
  RxString rxNewLabelName = ''.obs;
  RxString rxNewLabelValue = ''.obs;

  MainState() {
    ///Initialize variables
  }
}
