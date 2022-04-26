import 'dart:convert';

Comments commentsFromJson(String str) => Comments.fromJson(json.decode(str));

String commentsToJson(Comments data) => json.encode(data.toJson());

class Comments {
    Comments({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    Data? data;

    factory Comments.fromJson(Map<String, dynamic> json) => Comments(
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
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    int? currentPage;
    List<Data2>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    String? nextPageUrl;
    String? path;
    int? perPage;
    dynamic prevPageUrl;
    int? to;
    int? total;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Data2>.from(json["data"].map((x) => Data2.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class Data2 {
    Data2({
        this.id,
        this.userId,
        this.description,
        this.postId,
        this.postCommentId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.isFavorite,
        this.comments,
        this.user,
    });

    int? id;
    String? userId;
    String? description;
    String? postId;
    dynamic postCommentId;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    bool? isFavorite;
    List<dynamic>? comments;
    User? user;

    factory Data2.fromJson(Map<String, dynamic> json) => Data2(
        id: json["id"],
        userId: json["user_id"],
        description: json["description"],
        postId: json["post_id"],
        postCommentId: json["post_comment_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        isFavorite: json["is_favorite"],
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "description": description,
        "post_id": postId,
        "post_comment_id": postCommentId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
        "is_favorite": isFavorite,
        "comments": List<dynamic>.from(comments!.map((x) => x)),
        "user": user!.toJson(),
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
    String? description;
    String? username;
    String? verifyCode;
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
        username: json["username"],
        verifyCode: json["verify_code"],
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
        "is_follow": isFollow,
    };
}

class Link {
    Link({
        this.url,
        this.label,
        this.active,
    });

    String? url;
    String? label;
    bool? active;

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label,
        "active": active,
    };
}
