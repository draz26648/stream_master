import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
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

class DataGeneral {
  DataGeneral({
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
  List<Data>? data;
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

  factory DataGeneral.fromJson(Map<String, dynamic> json) => DataGeneral(
        currentPage: json["current_page"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
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

class Data {
  Data({
    this.id,
    this.title,
    this.description,
    this.path,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.favoritesCount,
    this.commentsCount,
    this.descriptionData,
    this.descriptionIframe,
    this.isFavorite,
    this.comments,
    this.user,
  });

  int? id;
  String? title;
  String? description;
  String? path;
  dynamic userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? favoritesCount;
  String? commentsCount;
  String? descriptionData;
  String? descriptionIframe;
  bool? isFavorite;
  List<Comment>? comments;
  User? user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        path: json["path"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        favoritesCount: json["favorites_count"],
        commentsCount: json["comments_count"],
        descriptionData: json["description_data"],
        descriptionIframe: json["description_iframe"],
        isFavorite: json["is_favorite"],
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        user: User.fromJson(json["user"]),
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
        "favorites_count": favoritesCount,
        "comments_count": commentsCount,
        "description_data": descriptionData,
        "description_iframe": descriptionIframe,
        "is_favorite": isFavorite,
        "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
        "user": user!.toJson(),
      };
}

class Comment {
  Comment({
    this.id,
    this.userId,
    this.description,
    this.postId,
    this.postCommentId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.isFavorite,
    this.user,
    this.attachments,
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
  User? user;
  List<dynamic>? attachments;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        userId: json["user_id"],
        description: json["description"],
        postId: json["post_id"],
        postCommentId: json["post_comment_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        isFavorite: json["is_favorite"],
        user: User.fromJson(json["user"]),
        attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
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
        "user": user!.toJson(),
        "attachments": List<dynamic>.from(attachments!.map((x) => x)),
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
  Description? description;
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
        description: json["description"] == null
            ? null
            : descriptionValues.map![json["description"]],
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
        "description":
            description == null ? null : descriptionValues.reverse[description],
        "is_follow": isFollow,
      };
}

enum Description { NULL, BIO_BIO_BIO_BIO_BIO_BAL_BLA_BLA }

final descriptionValues = EnumValues({
  "bio bio bio bio bio  bal bla bla":
      Description.BIO_BIO_BIO_BIO_BIO_BAL_BLA_BLA,
  "null": Description.NULL
});

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
