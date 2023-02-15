class User {
  // ignore_for_file: non_constant_identifier_names
  User({
    this.objectId,
    this.username,
    this.createdAt,
    this.updatedAt,
    this.ACL,
    this.sessionToken,
  });

  User.fromJson(dynamic json)
      : objectId = json['objectId'],
        username = json['username'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        ACL = json['ACL'],
        sessionToken = json['sessionToken'];

  String? objectId;
  String? username;
  String? createdAt;
  String? updatedAt;
  Map<String, dynamic>? ACL;
  String? sessionToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['objectId'] = objectId;
    map['username'] = username;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['ACL'] = ACL;
    map['sessionToken'] = sessionToken;
    return map;
  }
}
