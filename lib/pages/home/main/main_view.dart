import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/app/global.dart';
import 'package:object_note/modal/label.dart';
import 'package:object_note/modal/note.dart';

import 'main_logic.dart';

class MainView extends StatelessWidget {
  MainView({Key? key}) : super(key: key);

  final logic = Get.put(MainLogic());
  final state = Get.find<MainLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (Global.rxUser.value.objectId == null) {
        return Center(
          child: TextButton(
            onPressed: logic.onLoginTap,
            child: Text('Please login'.tr),
          ),
        );
      } else {
        return Row(
          children: [
            Expanded(child: buildLabelView(context)),
            Expanded(child: buildNoteView(context)),
          ],
        );
      }
    });
  }

  Widget buildNoteView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        ...state.rxListNote.value
            .map((note) => Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () =>
                            buildShowSelectLabelDialog(context, note),
                        onLongPress: () =>
                            buildNoteShowDeleteDialog(context, note),
                        child: Text('${note.objectId}'),
                      ),
                      ...note.labelIds?.map((id) {
                            Label? label = state.rxListLabel.value
                                .firstWhereOrNull(
                                    (label) => label.objectId == id);
                            return Text(label?.name ?? '');
                          }).toList() ??
                          [],
                    ],
                  ),
                ))
            .toList(),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: FloatingActionButton(
            heroTag: 'Create Note',
            onPressed: () => buildNoteShowCreateDialog(context),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Future<dynamic> buildShowSelectLabelDialog(BuildContext context, Note note) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: Text('Select Label'.tr),
              children: state.rxListLabel.value.map((label) {
                return SimpleDialogOption(
                  onPressed: () => logic
                      .addLabelToNote(label, note)
                      .then((value) => Navigator.pop(context, 'Select'.tr)),
                  child: Text('${label.name}'),
                );
              }).toList(),
            ));
  }

  buildNoteShowDeleteDialog(BuildContext context, Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Delete Note'.tr),
          content: Text('Are you sure to delete this Note?'.tr),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'.tr),
              child: Text('Cancel'.tr),
            ),
            TextButton(
              onPressed: () => logic
                  .deleteNote(note.objectId ?? '')
                  .then((value) => Navigator.pop(context, 'Delete'.tr)),
              child: Text('Delete'.tr),
            ),
          ]),
    );
  }

  buildNoteShowCreateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create Note'.tr),
        content: TextField(
          onChanged: (value) => state.rxNewLabelName.value = value,
          onSubmitted: (value) => createNote(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'.tr),
            child: Text('Cancel'.tr),
          ),
          TextButton(
            onPressed: () => createNote(context),
            child: Text('Create'.tr),
          ),
        ],
      ),
    );
  }

  createNote(BuildContext context) {
    logic.createNote().then(
          (value) => Navigator.pop(context, 'Create'.tr),
        );
  }

  Widget buildLabelView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        ...state.rxListLabel.value
            .map((label) => Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 20),
                  child: TextButton(
                    onPressed: () {},
                    onLongPress: () =>
                        buildLabelShowDeleteDialog(context, label),
                    child: Text('${label.name}'),
                  ),
                ))
            .toList(),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: FloatingActionButton(
            heroTag: 'Create Label',
            onPressed: () => buildLabelShowCreateDialog(context),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  buildLabelShowDeleteDialog(BuildContext context, Label label) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Delete Label'.tr),
          content: Text('Are you sure to delete this label?'.tr),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'.tr),
              child: Text('Cancel'.tr),
            ),
            TextButton(
              onPressed: () => logic
                  .deleteLabel(label.objectId ?? '')
                  .then((value) => Navigator.pop(context, 'Delete'.tr)),
              child: Text('Delete'.tr),
            ),
          ]),
    );
  }

  buildLabelShowCreateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create Label'.tr),
        content: TextField(
          onChanged: (value) => state.rxNewLabelName.value = value,
          onSubmitted: (value) => createLabel(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'.tr),
            child: Text('Cancel'.tr),
          ),
          TextButton(
            onPressed: () => createLabel(context),
            child: Text('Create'.tr),
          ),
        ],
      ),
    );
  }

  createLabel(BuildContext context) {
    logic
        .createLabel(state.rxNewLabelName.value)
        .then((value) => Navigator.pop(context, 'Create'.tr));
  }
}
