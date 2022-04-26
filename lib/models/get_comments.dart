import 'dart:convert';

GetComment getCommentFromJson(String str) =>
    GetComment.fromJson(json.decode(str));

String getCommentToJson(GetComment data) => json.encode(data.toJson());

class GetComment {
  GetComment({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory GetComment.fromJson(Map<String, dynamic> json) => GetComment(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.description,
    this.postId,
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.isFavorite,
  });

  String? description;
  String? postId;
  int? userId;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  bool? isFavorite;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        description: json["description"],
        postId: json["post_id"],
        userId: json["user_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        isFavorite: json["is_favorite"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "post_id": postId,
        "user_id": userId,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "id": id,
        "is_favorite": isFavorite,
      };
}
