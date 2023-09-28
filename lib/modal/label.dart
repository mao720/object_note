// ignore_for_file: non_constant_identifier_names

class Label {
  Label({
    this.objectId,
    this.createdAt,
    this.updatedAt,
    required this.name,
    required this.ACL,
  });

  Label.fromJson(Map<String, dynamic> json)
      : objectId = json['objectId'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        name = json['name'],
        ACL = json['ACL'];

  String? objectId;
  String? createdAt;
  String? updatedAt;
  String? name;
  Map<String, dynamic>? ACL;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['objectId'] = objectId;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['name'] = name;
    map['ACL'] = ACL;
    return map;
  }
}
