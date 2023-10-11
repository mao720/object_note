import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_note/core/app/global.dart';
import 'package:object_note/modal/label.dart';
import 'package:object_note/modal/note.dart';
import 'package:object_note/pages/home/dashboard/dashboard_logic.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  final logic = Get.put(DashboardLogic());
  final state = Get.find<DashboardLogic>().state;

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
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...state.rxListNote.value.where((note) {
                      var currentNote = state.rxCurrentNote.value;
                      return currentNote != null &&
                          (note.relatedNoteIds
                                  ?.contains(currentNote.objectId) ??
                              false);
                    }).map((note) {
                      return TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.primaryContainer),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                        ),
                        onPressed: () => state.rxCurrentNote.value = note,
                        child: Text('${note.name}'),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: buildNoteItem(
                  context,
                  state.rxCurrentNote.value ?? Note(name: '', ACL: {}),
                ),
              ),
            ),
          ],
        );
      }
    });
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
                onPressed: () {},
                onLongPress: () {},
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
    var currentLabelNote = state.rxListNote.value.firstWhereOrNull(
        (noteToFind) => noteToFind.objectId == relatedNoteIds?[index]);
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
          onPressed: () {},
          onLongPress: () {},
          child: Text(label.name ?? ''),
        ),
        const SizedBox(width: 10),
        switch (relatedValues?[index]) {
          null => switch (relatedNoteIds?[index]) {
              null => const SizedBox.shrink(),
              _ => TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primaryContainer),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                  ),
                  onPressed: () => state.rxCurrentNote.value = currentLabelNote,
                  child: Text(
                      '${currentLabelNote?.name ?? relatedNoteIds?[index]}'),
                ),
            },
          _ => Expanded(child: Text(relatedValues?[index])),
        }
      ],
    );
  }
}
