class User {
  // ignore_for_file: non_constant_identifier_names
  User({
    this.objectId,
    this.username,
    this.createdAt,
    this.updatedAt,
    this.ACL,
    this.sessionToken,
    this.avatar,
  });

  User.fromJson(dynamic json)
      : objectId = json['objectId'],
        username = json['username'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        ACL = json['ACL'],
        sessionToken = json['sessionToken'],
        avatar = json['avatar'];

  String? objectId;
  String? username;
  String? createdAt;
  String? updatedAt;
  Map<String, dynamic>? ACL;
  String? sessionToken;
  String? avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['objectId'] = objectId;
    map['username'] = username;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['ACL'] = ACL;
    map['sessionToken'] = sessionToken;
    map['avatar'] = avatar;
    return map;
  }
}
