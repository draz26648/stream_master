class Rigester {
  String? message;
  int? uid;
  String? token;

  Rigester({this.message, this.uid, this.token});

  Rigester.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    uid = json['uid'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['uid'] = this.uid;
    data['token'] = this.token;
    return data;
  }
}
