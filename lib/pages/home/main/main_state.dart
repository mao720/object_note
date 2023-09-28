import 'package:get/get.dart';
import 'package:object_note/modal/label.dart';
import 'package:object_note/modal/note.dart';

class MainState {
  Rx<List<Label>> rxListLabel = Rx([]);
  Rx<List<Note>> rxListNote = Rx([]);
  RxString rxNewLabelName = ''.obs;

  MainState() {
    ///Initialize variables
  }
}
