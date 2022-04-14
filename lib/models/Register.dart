

import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
    Register({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    Data? data;

    factory Register.fromJson(Map<String, dynamic> json) => Register(
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
        this.name,
        this.email,
        this.mobile,
        this.createdAt,
        this.id,
        this.isFollow,
    });

    String? name;
    String? email;
    int? mobile;
    DateTime? createdAt;
    int? id;
    bool? isFollow;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        isFollow: json["is_follow"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "mobile": mobile,
        "created_at": createdAt!.toIso8601String(),
        "id": id,
        "is_follow": isFollow,
    };
}
