import 'dart:convert';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  MessageModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
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
  List<ChatData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic? nextPageUrl;
  String? path;
  int? perPage;
  dynamic? prevPageUrl;
  int? to;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data:
            List<ChatData>.from(json["data"].map((x) => ChatData.fromJson(x))),
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

class ChatData {
  ChatData({
    this.id,
    this.chatId,
    this.message,
    this.userId,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  String? chatId;
  String? message;
  String? userId;
  String? status;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  factory ChatData.fromJson(Map<String, dynamic> json) => ChatData(
        id: json["id"],
        chatId: json["chat_id"],
        message: json["message"],
        userId: json["user_id"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chat_id": chatId,
        "message": message,
        "user_id": userId,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
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
    this.fcmToken,
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
  String? fcmToken;
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
        fcmToken: json["fcm_token"],
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
        "fcm_token": fcmToken,
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
