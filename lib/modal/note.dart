// ignore_for_file: non_constant_identifier_names

class Note {
  Note({
    this.objectId,
    this.createdAt,
    this.updatedAt,
    required this.name,
    this.labelIds,
    this.relatedValues,
    this.relatedNoteIds,
    required this.ACL,
  });

  Note.fromJson(Map<String, dynamic> json)
      : objectId = json['objectId'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        name = json['name'],
        labelIds = json['labelIds'],
        relatedValues = json['relatedValues'],
        relatedNoteIds = json['relatedNoteIds'],
        ACL = json['ACL'];

  String? objectId;
  String? createdAt;
  String? updatedAt;
  String? name;
  List<dynamic>? labelIds;
  List<dynamic>? relatedValues;
  List<dynamic>? relatedNoteIds;
  Map<String, dynamic>? ACL;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['objectId'] = objectId;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['name'] = name;
    map['labelIds'] = labelIds;
    map['relatedValues'] = relatedValues;
    map['relatedNoteIds'] = relatedNoteIds;
    map['ACL'] = ACL;
    return map;
  }
}
