class Note {
  Note({
    this.objectId,
    this.createdAt,
    this.updatedAt,
    required this.userId,
    this.labelIds,
    this.relatedValues,
    this.relatedNoteIds,
  });

  Note.fromJson(Map<String, dynamic> json)
      : objectId = json['objectId'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        userId = json['userId'],
        labelIds = json['labelIds'],
        relatedValues = json['relatedValues'],
        relatedNoteIds = json['relatedNoteIds'];

  String? objectId;
  String? createdAt;
  String? updatedAt;
  String? userId;
  List<dynamic>? labelIds;
  List<dynamic>? relatedValues;
  List<dynamic>? relatedNoteIds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['objectId'] = objectId;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['userId'] = userId;
    map['labelIds'] = labelIds;
    map['relatedValues'] = relatedValues;
    map['relatedNoteIds'] = relatedNoteIds;
    return map;
  }
}
