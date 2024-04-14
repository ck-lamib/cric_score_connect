import 'dart:convert';

List<FriendRequestUser> friendRequestUserFromJson(List<dynamic> userJsons) =>
    userJsons.map((userJson) => FriendRequestUser.fromJson(userJson)).toList();

class FriendRequestUser {
  final int? id;
  final String? senderId;
  final String? receiverId;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? senderUsername;
  final String? senderName;
  final String? profilePhotoPath;

  FriendRequestUser({
    this.id,
    this.senderId,
    this.receiverId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.senderUsername,
    this.senderName,
    this.profilePhotoPath,
  });

  FriendRequestUser copyWith({
    int? id,
    String? senderId,
    String? receiverId,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? senderUsername,
    String? senderName,
    String? profilePhotoPath,
  }) =>
      FriendRequestUser(
        id: id ?? this.id,
        senderId: senderId ?? this.senderId,
        receiverId: receiverId ?? this.receiverId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        senderUsername: senderUsername ?? this.senderUsername,
        senderName: senderName ?? this.senderName,
        profilePhotoPath: profilePhotoPath ?? this.profilePhotoPath,
      );

  factory FriendRequestUser.fromRawJson(String str) =>
      FriendRequestUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FriendRequestUser.fromJson(Map<String, dynamic> json) =>
      FriendRequestUser(
        id: json["id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        senderUsername: json["sender_username"],
        senderName: json["sender_name"],
        profilePhotoPath: json["profile_photo_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "sender_username": senderUsername,
        "sender_name": senderName,
        "profile_photo_path": profilePhotoPath,
      };
}
