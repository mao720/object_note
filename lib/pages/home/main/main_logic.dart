import 'package:get/get.dart';
import 'package:object_note/core/app/app_route.dart';
import 'package:object_note/core/app/global.dart';
import 'package:object_note/core/http/api.dart';
import 'package:object_note/modal/label.dart';
import 'package:object_note/modal/note.dart';
import 'package:object_note/widgets/toast.dart';

import 'main_state.dart';

class MainLogic extends GetxController {
  final MainState state = MainState();
  late Worker worker;

  @override
  onInit() {
    super.onInit();
    onUserChange();
    worker = ever(
      Global.rxUser,
      (user) {
        onUserChange();
      },
    );
  }

  @override
  onClose() {
    worker.dispose();
    super.onClose();
  }

  onUserChange() {
    if (!Global.isLogin()) return;
    getListLabel();
    getListNote();
  }

  createNote(String name) async {
    var userId = Global.rxUser.value.objectId;
    if (userId == null) return;
    var newNote = Note(name: name, ACL: {
      userId: {'read': true, 'write': true}
    });
    await Api.createNote(newNote);
    await getListNote();
  }

  deleteNote(String id) async {
    await Api.deleteNote(id);
    await getListNote();
    Toast.show('Delete Note Success'.tr);
  }

  getListNote() async {
    var value = await Api.getNotes();
    state.rxListNote.value = value;
  }

  getListLabel() async {
    var value = await Api.getLabels();
    state.rxListLabel.value = value;
  }

  createLabel(String labelName) async {
    var userId = Global.rxUser.value.objectId;
    if (userId == null) return;
    var newLabel = Label(name: labelName, ACL: {
      userId: {'read': true, 'write': true}
    });
    bool isLabelExist = await Api.isLabelExist(newLabel);
    if (isLabelExist) {
      Toast.error('Label already exist'.tr);
      return;
    }
    await Api.createLabel(newLabel);
    await getListLabel();
    Toast.show('Create Label Success'.tr);
  }

  updateLabel(String labelName, Label label) async {
    var Label(objectId: labelId) = label;
    if (labelId == null) {
      Toast.show('No Id Found'.tr);
      return;
    }
    await Api.updateLabel({'name': labelName}, labelId);
    await getListLabel();
    Toast.show('Update Label Success'.tr);
  }

  deleteLabel(String id) async {
    await Api.deleteLabel(id);
    await getListLabel();
    Toast.show('Delete Label Success'.tr);
  }

  addLabelToNote(Label label, Note note) async {
    var Note(objectId: noteId, :labelIds, :relatedValues, :relatedNoteIds) =
        note;
    var labelId = label.objectId;
    if (labelId == null || noteId == null) {
      Toast.show('No Id Found'.tr);
      return;
    }

    (labelIds ??= []).add(labelId);
    (relatedValues ??= []).add(null);
    (relatedNoteIds ??= []).add(null);
    await Api.updateNote({
      'labelIds': labelIds,
      'relatedValues': relatedValues,
      'relatedNoteIds': relatedNoteIds,
    }, noteId);
    await getListNote();
  }

  onLoginTap() {
    Get.toNamed(AppRoute.loginPage);
  }

  addValueToLabel(Note note, Label label, int labelIndex, String value) async {
    var Note(objectId: noteId, :labelIds, :relatedValues, :relatedNoteIds) =
        note;
    var labelId = label.objectId;
    if (labelId == null || noteId == null || labelIds == null) {
      Toast.show('No Id Found'.tr);
      return;
    }
    (relatedValues ??= List.filled(labelIds.length, null))[labelIndex] = value;
    (relatedNoteIds ??= List.filled(labelIds.length, null))[labelIndex] = null;
    await Api.updateNote({
      'relatedValues': relatedValues,
      'relatedNoteIds': relatedNoteIds,
    }, noteId);
    await getListNote();
  }

  addNoteIdToLabel(
      Note note, Label label, int labelIndex, String? noteIdToAdd) async {
    var Note(objectId: noteId, :labelIds, :relatedValues, :relatedNoteIds) =
        note;
    var labelId = label.objectId;
    if (noteIdToAdd == null ||
        labelId == null ||
        noteId == null ||
        labelIds == null) {
      Toast.show('No Id Found'.tr);
      return;
    }
    (relatedValues ??= List.filled(labelIds.length, null))[labelIndex] = null;
    (relatedNoteIds ??= List.filled(labelIds.length, null))[labelIndex] =
        noteIdToAdd;
    await Api.updateNote({
      'relatedValues': relatedValues,
      'relatedNoteIds': relatedNoteIds,
    }, noteId);
    await getListNote();
  }

  deleteNoteLabel(Note note, int labelIndex) async {
    var Note(objectId: noteId, :labelIds, :relatedValues, :relatedNoteIds) =
        note;
    if (noteId == null || labelIds == null) {
      Toast.show('No Id Found'.tr);
      return;
    }

    labelIds.removeAt(labelIndex);
    (relatedValues ??= List.filled(labelIds.length, null)).removeAt(labelIndex);
    (relatedNoteIds ??= List.filled(labelIds.length, null))
        .removeAt(labelIndex);
    await Api.updateNote({
      'labelIds': labelIds,
      'relatedValues': relatedValues,
      'relatedNoteIds': relatedNoteIds,
    }, noteId);
    await getListNote();
  }
}
