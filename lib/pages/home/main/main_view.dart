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
        return Column(
          children: [
            buildLabelView(context),
            Expanded(child: buildNoteView(context)),
          ],
        );
      }
    });
  }

  Widget buildNoteView(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            ...state.rxListNote.value
                .map((note) => buildNoteItem(context, note))
                .toList(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () => logic.createNote(),
                child: Text('Create Note'.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildNoteItem(BuildContext context, Note note, [String? rootObjectId]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primaryContainer),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
                onPressed: () => buildShowSelectLabelDialog(context, note),
                onLongPress: () => buildNoteShowDeleteDialog(context, note),
                child: Text('${note.objectId}'),
              ),
              const SizedBox(height: 10),
              createNoteContent(context, note, rootObjectId),
            ],
          ),
        ),
      ),
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
                      .then((value) => Navigator.pop(context)),
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
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'.tr),
            ),
            TextButton(
              onPressed: () => logic
                  .deleteNote(note.objectId ?? '')
                  .then((value) => Navigator.pop(context)),
              child: Text('Delete'.tr),
            ),
          ]),
    );
  }

  Widget buildLabelView(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: IconButton(
                onPressed: () => buildLabelShowCreateDialog(context),
                icon: const Icon(Icons.add),
              ),
            ),
            ...state.rxListLabel.value
                .map((label) => TextButton(
                      onPressed: () {},
                      onLongPress: () =>
                          buildLabelShowDeleteDialog(context, label),
                      child: Text('${label.name}'),
                    ))
                .toList(),
          ],
        ),
      ),
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
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'.tr),
            ),
            TextButton(
              onPressed: () => logic
                  .deleteLabel(label.objectId ?? '')
                  .then((value) => Navigator.pop(context)),
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
            onPressed: () => Navigator.pop(context),
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
        .then((value) => Navigator.pop(context));
  }

  createNoteContent(BuildContext context, Note note, String? rootObjectId) {
    var Note(:labelIds, :relatedValues, :relatedNoteIds) = note;
    return switch (labelIds) {
      null => const SizedBox.shrink(),
      _ => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...labelIds.asMap().keys.map((index) {
              Label? label = state.rxListLabel.value.firstWhereOrNull(
                  (label) => label.objectId == labelIds[index]);
              return switch (label) {
                null => const SizedBox.shrink(),
                _ => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer),
                          minimumSize:
                              MaterialStateProperty.all(const Size(0, 0)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(4)),
                        ),
                        onPressed: () =>
                            buildNoteShowAddValueDialog(context, note, label),
                        child: Text(label.name ?? ''),
                      ),
                      const SizedBox(width: 10),
                      switch (relatedValues?[index]) {
                        null => switch (relatedNoteIds?[index]) {
                            null => const SizedBox.shrink(),
                            _ => relatedNoteIds?[index] == note.objectId ||
                                    relatedNoteIds?[index] == rootObjectId
                                ? TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                    ),
                                    onPressed: () {},
                                    child: Text('${relatedNoteIds?[index]}'),
                                  )
                                : Expanded(
                                    child: buildNoteItem(
                                        context,
                                        state.rxListNote.value.firstWhereOrNull(
                                                (noteToFind) =>
                                                    noteToFind.objectId ==
                                                    relatedNoteIds?[index]) ??
                                            Note(ACL: {}),
                                        note.objectId)),
                          },
                        _ => Expanded(child: Text(relatedValues?[index])),
                      }
                    ],
                  ),
              };
            }).toList()
          ],
        )
    };
  }

  buildNoteShowAddValueDialog(BuildContext context, Note note, Label label) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${'Add Value'.tr} to ${label.name}'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  minLines: 1,
                  maxLines: 10,
                  decoration: InputDecoration(labelText: 'Input Value'.tr),
                  onChanged: (value) => state.rxNewLabelValue.value = value,
                  onSubmitted: (value) => addValueToLabel(context, note, label),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Or Select Note'.tr),
              ),
              ...state.rxListNote.value.map((noteToAdd) => TextButton(
                    onPressed: () => addNoteIdToLabel(
                        context, note, label, noteToAdd.objectId),
                    child: Text(noteToAdd.objectId ?? ''),
                  ))
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'.tr),
          ),
          TextButton(
            onPressed: () => addValueToLabel(context, note, label),
            child: Text('Create'.tr),
          ),
        ],
      ),
    );
  }

  addNoteIdToLabel(
      BuildContext context, Note note, Label label, String? noteIdToAdd) {
    logic
        .addNoteIdToLabel(note, label, noteIdToAdd)
        .then((value) => Navigator.pop(context));
  }

  addValueToLabel(BuildContext context, Note note, Label label) {
    logic
        .addValueToLabel(note, label, state.rxNewLabelValue.value)
        .then((value) => Navigator.pop(context));
  }
}
