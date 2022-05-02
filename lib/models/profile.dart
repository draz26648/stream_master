
import 'dart:convert';

ProfileModel profileFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    ProfileModel({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    UserData? data;

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        message: json["message"],
        data: UserData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
    };
}

class UserData {
    UserData({
        this.id,
        this.name,
        this.email,
        this.mobile,
        this.avatar,
        this.createdAt,
        this.emailNotification,
        this.smsNotification,
        this.description,
        this.username,
        this.verifyCode,
        this.postsCount,
        this.postCommentsCount,
        this.postFavoritesCount,
        this.commentFavoritesCount,
        this.followersCount,
        this.followingsCount,
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
    String? username;
    String? verifyCode;
    String? postsCount;
    String? postCommentsCount;
    String? postFavoritesCount;
    String? commentFavoritesCount;
    String? followersCount;
    String? followingsCount;
    bool? isFollow;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        avatar: json["avatar"],
        createdAt: DateTime.parse(json["created_at"]),
        emailNotification: json["email_notification"],
        smsNotification: json["sms_notification"],
        description: json["description"],
        username: json["username"],
        verifyCode: json["verify_code"],
        postsCount: json["posts_count"],
        postCommentsCount: json["post_comments_count"],
        postFavoritesCount: json["post_favorites_count"],
        commentFavoritesCount: json["comment_favorites_count"],
        followersCount: json["followers_count"],
        followingsCount: json["followings_count"],
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
        "username": username,
        "verify_code": verifyCode,
        "posts_count": postsCount,
        "post_comments_count": postCommentsCount,
        "post_favorites_count": postFavoritesCount,
        "comment_favorites_count": commentFavoritesCount,
        "followers_count": followersCount,
        "followings_count": followingsCount,
        "is_follow": isFollow,
    };
}
