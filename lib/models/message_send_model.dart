import 'dart:convert';

MessageSendModel messageSendModelFromJson(String str) =>
    MessageSendModel.fromJson(json.decode(str));

String messageSendModelToJson(MessageSendModel data) =>
    json.encode(data.toJson());

class MessageSendModel {
  MessageSendModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  MessageData? data;

  factory MessageSendModel.fromJson(Map<String, dynamic> json) =>
      MessageSendModel(
        status: json["status"],
        message: json["message"],
        data: MessageData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class MessageData {
  MessageData({
    this.message,
    this.userId,
    this.chatId,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.user,
  });

  String? message;
  int? userId;
  int? chatId;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  User? user;

  factory MessageData.fromJson(Map<String, dynamic> json) => MessageData(
        message: json["message"],
        userId: json["user_id"],
        chatId: json["chat_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user_id": userId,
        "chat_id": chatId,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "id": id,
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
