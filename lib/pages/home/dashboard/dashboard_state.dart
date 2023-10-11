import 'package:get/get.dart';
import 'package:object_note/modal/label.dart';
import 'package:object_note/modal/note.dart';

class DashboardState {
  Rx<List<Note>> rxListNote = Rx([]);
  Rx<List<Label>> rxListLabel = Rx([]);
  Rx<Note?> rxCurrentNote = Rx(null);
}
