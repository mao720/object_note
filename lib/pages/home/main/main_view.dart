import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/app/global.dart';
import 'package:object_note/modal/label.dart';
import 'package:object_note/modal/note.dart';

import 'main_logic.dart';

class MainView extends StatelessWidget {
  MainView({super.key});

  final logic = Get.put(MainLogic());
  final state = Get.find<MainLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!Global.isLogin()) {
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
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () => buildNoteShowCreateDialog(context),
                    child: Text('Create Note'.tr),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Search'.tr,
                          border: const OutlineInputBorder()),
                      onChanged: (value) => state.rxFilterText.value = value,
                      onSubmitted: (value) {},
                    ),
                  )
                ],
              ),
            ),
            ...state.rxListNote.value
                .where((note) =>
                    state.rxFilterText.value.isEmpty ||
                    (note.name?.contains(state.rxFilterText.value) ?? false))
                .map((note) => buildNoteItem(context, note))
                .toList(),
          ],
        ),
      ),
    );
  }

  buildNoteItem(BuildContext context, Note note, [String? rootObjectId]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
                child: Text('${note.name}'),
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

  buildNoteShowCreateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create Note'.tr),
        content: TextField(
          onChanged: (value) => state.rxNewNoteName.value = value,
          onSubmitted: (value) => createNote(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
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
    logic
        .createNote(state.rxNewNoteName.value)
        .then((value) => Navigator.pop(context));
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
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                onPressed: () => buildLabelShowCreateDialog(context),
                icon: const Icon(Icons.add),
              ),
            ),
            ...state.rxListLabel.value
                .map(
                  (label) => TextButton(
                    style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(10)),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () =>
                        buildLabelShowCreateDialog(context, label: label),
                    onLongPress: () =>
                        buildLabelShowDeleteDialog(context, label),
                    child: Text('${label.name}'),
                  ),
                )
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

  buildLabelShowCreateDialog(BuildContext context, {Label? label}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(label == null ? 'Create Label'.tr : 'Update Label'.tr),
        content: TextField(
          onChanged: (value) => state.rxNewLabelName.value = value,
          onSubmitted: (value) => createLabel(context, label: label),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'.tr),
          ),
          TextButton(
            onPressed: () => createLabel(context, label: label),
            child: Text(label == null ? 'Create'.tr : 'Update'.tr),
          ),
        ],
      ),
    );
  }

  createLabel(BuildContext context, {Label? label}) {
    if (label == null) {
      logic
          .createLabel(state.rxNewLabelName.value)
          .then((value) => Navigator.pop(context));
    } else {
      logic
          .updateLabel(state.rxNewLabelName.value, label)
          .then((value) => Navigator.pop(context));
    }
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
              if (label == null || labelIds.indexOf(labelIds[index]) != index) {
                return const SizedBox.shrink();
              }
              List<Widget> sameLabelRow = [];
              var sameIndex = index;
              while (labelIds.indexOf(labelIds[index], sameIndex) != -1) {
                var currentIndex = labelIds.indexOf(labelIds[index], sameIndex);
                sameLabelRow.add(buildNoteLabelRow(context, note, label,
                    currentIndex, relatedValues, relatedNoteIds, rootObjectId));
                sameIndex = currentIndex + 1;
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sameLabelRow.length <= 1
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            height: 1,
                          ),
                        ),
                  ...sameLabelRow,
                  sameLabelRow.length <= 1
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            height: 1,
                          ),
                        ),
                ],
              );
            }).toList(),
          ],
        )
    };
  }

  buildNoteLabelRow(
      BuildContext context,
      Note note,
      Label label,
      int index,
      List<dynamic>? relatedValues,
      List<dynamic>? relatedNoteIds,
      String? rootObjectId) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => Theme.of(context).colorScheme.tertiaryContainer),
            minimumSize: MaterialStateProperty.all(const Size(1, 1)),
            padding: MaterialStateProperty.all(const EdgeInsets.all(4)),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () =>
              buildNoteShowAddValueDialog(context, note, label, index),
          onLongPress: () =>
              buildNoteShowDeleteLabelDialog(context, note, index),
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
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.primaryContainer),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
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
                              Note(name: 'NOT FOUND', ACL: {}),
                          note.objectId)),
            },
          _ => Expanded(child: Text(relatedValues?[index])),
        }
      ],
    );
  }

  buildNoteShowAddValueDialog(
      BuildContext context, Note note, Label label, int labelIndex) {
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
                  onSubmitted: (value) =>
                      addValueToLabel(context, note, label, labelIndex),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Or Select Note'.tr),
              ),
              ...state.rxListNote.value.map((noteToAdd) => TextButton(
                    onPressed: () => addNoteIdToLabel(
                        context, note, label, labelIndex, noteToAdd.objectId),
                    child: Text(noteToAdd.name ?? ''),
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
            onPressed: () => addValueToLabel(context, note, label, labelIndex),
            child: Text('Create'.tr),
          ),
        ],
      ),
    );
  }

  addNoteIdToLabel(BuildContext context, Note note, Label label, int labelIndex,
      String? noteIdToAdd) {
    logic
        .addNoteIdToLabel(note, label, labelIndex, noteIdToAdd)
        .then((value) => Navigator.pop(context));
  }

  addValueToLabel(
      BuildContext context, Note note, Label label, int labelIndex) {
    logic
        .addValueToLabel(note, label, labelIndex, state.rxNewLabelValue.value)
        .then((value) => Navigator.pop(context));
  }

  buildNoteShowDeleteLabelDialog(
      BuildContext context, Note note, int labelIndex) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Delete Note Label'.tr),
          content: Text('Are you sure to delete this label?'.tr),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'.tr),
            ),
            TextButton(
              onPressed: () => logic
                  .deleteNoteLabel(note, labelIndex)
                  .then((value) => Navigator.pop(context)),
              child: Text('Delete'.tr),
            ),
          ]),
    );
  }
}
