import 'dart:convert';

LoginModel loginFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  User? data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        data: User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.avatar,
    this.createdAt,
    this.emailNotification,
    this.smsNotification,
    this.description,
    this.postsCount,
    this.postCommentsCount,
    this.postFavoritesCount,
    this.commentFavoritesCount,
    this.token,
    this.isFollow,
  });

  int? id;
  String? name;
  String? email;
  String? mobile;
  String? avatar;
  DateTime? createdAt;
  String? emailNotification;
  String? smsNotification;
  dynamic description;
  String? postsCount;
  String? postCommentsCount;
  String? postFavoritesCount;
  String? commentFavoritesCount;
  String? token;
  bool? isFollow;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        avatar: json["avatar"],
        createdAt: DateTime.parse(json["created_at"]),
        emailNotification: json["email_notification"],
        smsNotification: json["sms_notification"],
        description: json["description"],
        postsCount: json["posts_count"],
        postCommentsCount: json["post_comments_count"],
        postFavoritesCount: json["post_favorites_count"],
        commentFavoritesCount: json["comment_favorites_count"],
        token: json["token"],
        isFollow: json["is_follow"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "avatar": avatar,
        "created_at": createdAt!.toIso8601String(),
        "email_notification": emailNotification,
        "sms_notification": smsNotification,
        "description": description,
        "posts_count": postsCount,
        "post_comments_count": postCommentsCount,
        "post_favorites_count": postFavoritesCount,
        "comment_favorites_count": commentFavoritesCount,
        "token": token,
        "is_follow": isFollow,
      };
}
