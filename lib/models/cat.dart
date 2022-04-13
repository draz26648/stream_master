import 'package:flutter/material.dart';

// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

Categories categoriesFromJson(String str) =>
    Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
  Categories({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Cat>? data;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        status: json["status"],
        message: json["message"],
        data: List<Cat>.from(json["data"].map((x) => Cat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Cat {
  int? id;
  String? name;
  Color color = Colors.white;

  Cat({this.id, this.name});

  Cat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
