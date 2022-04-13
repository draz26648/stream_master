import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../helper/shared_prefrences_helper.dart';

class Controller {
  dynamic apiurl = "https://stream.alkmal.com/api";
  bool isLoading = false;

  Future<dynamic> Register(
      {name,
      email,
      mobile,
      password,
      confirmPassword,
      interests,
      gender,
      birthdate}) async {
    var mydata = {
      "name": '$name',
      "image": '$email',
      "voice": '$password',
      "mobile": '$mobile',
      "email": '$email',
      "interests": '$interests',
      "gender": '$gender',
      "birthdate": '$birthdate',
      "password": '$password',
      "password_confirmation": '$confirmPassword'
    };
    print(" fgd ${mydata}");
    var res = await http.post(Uri.parse("$apiurl/register"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: mydata);
    print("ggggggggggggg ${res.body}");

    final data = await json.decode(res.body);
    if (res.statusCode == 200) {
      print(data);
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> getCategories() async {
    var res = await http.get(
      Uri.parse("$apiurl/categories"),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8'
      },
    );
    final Map<String, dynamic> map = await json.decode(res.body);

    final List<dynamic> data = map['data'];

    if (res.statusCode == 200) {
      print(data);
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> Login({email, password}) async {
    var mydata = {
      "email": '$email',
      "password": '$password',
    };

    print(mydata);

    var res = await http.post(Uri.parse("$apiurl/login"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: mydata);
    print("ggggggggggggg ${res.body}");

    final data = await json.decode(res.body);
    if (res.statusCode == 200) {
      print(data);
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> getPost() async {
    
    var header;
    if (SharedPrefrencesHelper.sharedPrefrencesHelper.getLogin()!) {
      print(
          "is login ${SharedPrefrencesHelper.sharedPrefrencesHelper.getToken()}");
      header = <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8',
        'Authorization':
            'Bearer ${SharedPrefrencesHelper.sharedPrefrencesHelper.getToken()}',
        'Accept': 'application/json'
      };
    } else {
      header = <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8'
      };
      print('you are in gust mode');
    }
    var res = await http.get(Uri.parse("$apiurl/posts"), headers: header);

    final Map<String, dynamic> map = await json.decode(res.body);
    final Map<String, dynamic> data1 = map['data'];
    final List<dynamic> data = data1['data'];
    if (res.statusCode == 200) {
      print(data);
      return data;
    } else {
      return print(map['message']);
    }
  }

  Future<dynamic> getComment(postId) async {
    var res = await http.get(
      Uri.parse("$apiurl/comments?post_id=$postId"),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8'
      },
    );
    final data = await json.decode(res.body);
    if (res.statusCode == 200) {
      print(data);
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> addComment({post_id, description}) async {
    var mydata = {
      "post_id": '$post_id',
      "description": '$description',
    };

    var res = await http.post(Uri.parse("$apiurl/comments"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8',
          'Authorization':
              'Bearer ${SharedPrefrencesHelper.sharedPrefrencesHelper.getToken()}',
          'Accept': 'application/json'
        },
        body: mydata);
    print("ggggggggggggg ${res}");

    final data = await json.decode(res.body);
    if (res.statusCode == 200) {
      print(data);
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> addFllow({user_id}) async {
    var mydata = {
      "user_id": '$user_id',
    };

    var res = await http.post(Uri.parse("$apiurl/follow"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8',
          'Authorization':
              'Bearer ${SharedPrefrencesHelper.sharedPrefrencesHelper.getToken()}',
          'Accept': 'application/json'
        },
        body: mydata);
    print("ggggggggggggg ${res.body}");

    final data = await json.decode(res.body);
    if (res.statusCode == 200) {
      print(data);
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> addLike({post_id}) async {
    var mydata = {
      "post_id": '$post_id',
    };

    var res = await http.post(Uri.parse("$apiurl/like"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8',
          'Authorization':
              'Bearer ${SharedPrefrencesHelper.sharedPrefrencesHelper.getToken()}',
          'Accept': 'application/json'
        },
        body: mydata);
    print("ggggggggggggg ${res}");
    final data = await json.decode(res.body);
    if (res.statusCode == 200) {
      // final data = await json.decode(res.body);
      print(data);
      return data;
    } else {
      // return "error";
      print(data);
      return data;
    }
  }

  Future<dynamic> addPost({title, description, path}) async {
    var mydata = {
      "title": '$title',
      "description": '$description',
      "path": '$path',
    };

    var res = await http.post(Uri.parse("$apiurl/posts"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8',
          'Authorization':
              'Bearer ${SharedPrefrencesHelper.sharedPrefrencesHelper.getToken()}',
          'Accept': 'application/json'
        },
        body: mydata);
    print("ggggggggggggg ${res}");

    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      print(data);
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> getProfile() async {
    print(" ffffg ${SharedPrefrencesHelper.sharedPrefrencesHelper.getToken()}");
    var res = await http.get(
      Uri.parse("$apiurl/profile"),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8',
        'Authorization':
            'Bearer ${SharedPrefrencesHelper.sharedPrefrencesHelper.getToken()}',
        'Accept': 'application/json'
      },
    );
    final data = await json.decode(res.body);
    if (res.statusCode == 200) {
      print(data);
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> editProfile(File image,
      {name, description, email, mobile, password}) async {
    var postUri = Uri.parse("$apiurl/profile");
    final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8])?.split('/');

    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', postUri);
    imageUploadRequest.fields['name'] = name;
    imageUploadRequest.fields['description'] = description;
    imageUploadRequest.fields['mobile'] = mobile;
    imageUploadRequest.fields['email'] = email;
    imageUploadRequest.fields['password'] = password;
    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('image', image.path,
        contentType: MediaType(mimeTypeData![0], mimeTypeData[1]));
    // Explicitly pass the extension of the image with request body
    // Since image_picker has some bugs due which it mixes up
    // image extension with file name like this filenamejpge
    // Which creates some problem at the server side to manage
    // or verify the file extension

//    imageUploadRequest.fields['ext'] = mimeTypeData[1];

    imageUploadRequest.files.add(file);

    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      final data = await json.decode(response.body);
      if (response.statusCode != 200) {
        return data;
      } else {
        return data;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> uploadVideo(
      {required File? postPath, title, description}) async {
    var header = <String, String>{
      'Context-Type': 'application/json;charSet=UTF-8',
      'Authorization':
          'Bearer ${SharedPrefrencesHelper.sharedPrefrencesHelper.getToken()}',
      'Accept': 'application/json'
    };

    var postUri = Uri.parse("$apiurl/posts");
    final mimeTypeData =
        lookupMimeType(postPath!.path, headerBytes: [0xFF, 0xD8])?.split('/');

    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', postUri);
    imageUploadRequest.fields['title'] = title;
    imageUploadRequest.fields['description'] = description;
    imageUploadRequest.headers.addAll(header);
    // imageUploadRequest.fields['phone'] = phone;
    // imageUploadRequest.fields['twitter'] = twitter;
    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('path', postPath.path,
        contentType: MediaType(mimeTypeData![0], mimeTypeData[1]));
    // Explicitly pass the extension of the image with request body
    // Since image_picker has some bugs due which it mixes up
    // image extension with file name like this filenamejpge
    // Which creates some problem at the server side to manage
    // or verify the file extension

//    imageUploadRequest.fields['ext'] = mimeTypeData[1];

    imageUploadRequest.files.add(file);

    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      final data = await json.decode(response.body);
      if (response.statusCode != 200) {
        return data;
      } else {
        return data;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } catch (e) {
      print(e);
    }
  }
}