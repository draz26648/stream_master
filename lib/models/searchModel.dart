

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
    SearchModel({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    Data? data;

    factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
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
        this.users,
        this.posts,
        this.categories,
    });

    List<User>? users;
    List<Post>? posts;
    List<dynamic>? categories;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
        categories: List<dynamic>.from(json["categories"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users!.map((x) => x.toJson())),
        "posts": List<dynamic>.from(posts!.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories!.map((x) => x)),
    };
}

class Post {
    Post({
        this.id,
        this.title,
        this.description,
        this.path,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.categoryId,
        this.allowShare,
        this.allowDuets,
        this.public,
        this.favoritesCount,
        this.commentsCount,
        this.descriptionData,
        this.descriptionIframe,
        this.isFavorite,
    });

    int? id;
    String? title;
    String? description;
    String? path;
    String? userId;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    dynamic categoryId;
    String? allowShare;
    String? allowDuets;
    String? public;
    String? favoritesCount;
    String? commentsCount;
    String? descriptionData;
    String? descriptionIframe;
    bool? isFavorite;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        path: json["path"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        categoryId: json["category_id"],
        allowShare: json["allow_share"],
        allowDuets: json["allow_duets"],
        public: json["public"],
        favoritesCount: json["favorites_count"],
        commentsCount: json["comments_count"],
        descriptionData: json["description_data"],
        descriptionIframe: json["description_iframe"],
        isFavorite: json["is_favorite"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "path": path,
        "user_id": userId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
        "category_id": categoryId,
        "allow_share": allowShare,
        "allow_duets": allowDuets,
        "public": public,
        "favorites_count": favoritesCount,
        "comments_count": commentsCount,
        "description_data": descriptionData,
        "description_iframe": descriptionIframe,
        "is_favorite": isFavorite,
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
        this.username,
        this.verifyCode,
        this.fcmToken,
        this.isFollow,
    });

    int? id;
    Name? name;
    String? email;
    String? mobile;
    String? avatar;
    DateTime? createdAt;
    String? emailNotification;
    String? smsNotification;
    String? description;
    String? username;
    String? verifyCode;
    String? fcmToken;
    bool? isFollow;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: nameValues.map![json["name"]],
        email: json["email"],
        mobile: json["mobile"],
        avatar: json["avatar"],
        createdAt: DateTime.parse(json["created_at"]),
        emailNotification: json["email_notification"],
        smsNotification: json["sms_notification"],
        description: json["description"] == null ? null : json["description"],
        username: json["username"],
        verifyCode: json["verify_code"],
        fcmToken: json["fcm_token"],
        isFollow: json["is_follow"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "email": email,
        "mobile": mobile,
        "avatar": avatar,
        "created_at": createdAt!.toIso8601String(),
        "email_notification": emailNotification,
        "sms_notification": smsNotification,
        "description": description == null ? null : description,
        "username": username,
        "verify_code": verifyCode,
        "fcm_token": fcmToken,
        "is_follow": isFollow,
    };
}

enum Name { TEST, TEST2 }

final nameValues = EnumValues({
    "test": Name.TEST,
    "test2": Name.TEST2
});

class EnumValues<T> {
    Map<String, T>? map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map!.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap!;
    }
}



