class User {
  User(
    this.objectId,
    this.username,
    this.createdAt,
    this.updatedAt,
    this.sessionToken,
  );

  User.fromJson(dynamic json)
      : objectId = json['objectId'] ?? '',
        username = json['username'] ?? '',
        createdAt = json['createdAt'] ?? '',
        updatedAt = json['updatedAt'] ?? '',
        sessionToken = json['sessionToken'] ?? '';

  String objectId;
  String username;
  String createdAt;
  String updatedAt;
  String sessionToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['objectId'] = objectId;
    map['username'] = username;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['sessionToken'] = sessionToken;
    return map;
  }
}
