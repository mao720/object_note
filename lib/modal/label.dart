class Label {
  Label({
    this.objectId,
    this.createdAt,
    this.updatedAt,
    required this.userId,
    required this.name,
  });

  Label.fromJson(Map<String, dynamic> json)
      : objectId = json['objectId'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        userId = json['userId'],
        name = json['name'];

  String? objectId;
  String? createdAt;
  String? updatedAt;
  String? userId;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['objectId'] = objectId;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['userId'] = userId;
    map['name'] = name;
    return map;
  }
}
