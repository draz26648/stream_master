import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:stream_master/models/comments_model.dart';
import 'package:stream_master/models/login_model.dart';

import '../helper/shared_prefrences_helper.dart';

class Controller {
  dynamic apiurl = "https://stream.alkmal.com/api";
  bool isLoading = false;

//register web service
  Future<dynamic> register(
      {name,
      email,
      mobile,
      password,
      confirmPassword,
      interests,
      gender,
      birthdate}) async {
    var mydata = {
      "email": '$email',
      "mobile": '$mobile',
      "password": '$password',
      "password_confirmation": '$confirmPassword',
      "name": '$name',
    };
    print(" fgd ${mydata}");
    var res = await http.post(Uri.parse("$apiurl/register"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: mydata);
    print(" ${res.body}");

    final data = await json.decode(res.body);
    if (res.statusCode == 200) {
      print(data);
      return data;
    } else {
      return data;
    }
  }

// interests web service
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

//login web service

  Future<dynamic> Login({email, password}) async {
    var mydata = {
      "username": '$email',
      "password": '$password',
    };

    print('you input $mydata');
    LoginModel loginmodel = LoginModel();
    var res = await http.post(Uri.parse("$apiurl/login"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: mydata);

    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      print('fetched data is $data');
      return data;
    } else {
      return data;
    }
  }

  //logout web service
  Future<dynamic> logout() async {
    var header;
    String token =
        '${SharedPrefrencesHelper.sharedPrefrencesHelper.getToken()}';
    header = <String, String>{
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };
    var res = await http.get(
      Uri.parse("$apiurl/logout"),
      headers: header,
    );
    final data = await json.decode(res.body);
    if (res.statusCode == 200) {
      print(data);
      await SharedPrefrencesHelper.sharedPrefrencesHelper.setIsLogin(false);
      await SharedPrefrencesHelper.sharedPrefrencesHelper.logout(token);
      return data;
    } else {
      return data;
    }
  }

//home videos web service
  Future<dynamic> getPost(int? page) async {
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
    var res =
        await http.get(Uri.parse("$apiurl/posts?page=$page"), headers: header);

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

  //get videos pages counts
  Future<dynamic> getPostPages() async {
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

    final List<dynamic> data = [];
    map.forEach((key, value) {
      if (key == 'data') {
        data.add(value);
      }
    });
    if (res.statusCode == 200) {
      print(data);
      return data;
    } else {
      return print(map['message']);
    }
  }

  //search web Service

  Future<dynamic> getSearchResult(String? query) async {
    var header;
    header = <String, String>{
      'Context-Type': 'application/json;charSet=UTF-8',
      'Authorization':
          'Bearer ${SharedPrefrencesHelper.sharedPrefrencesHelper.getToken()}',
      'Accept': 'application/json'
    };
    var res =
        await http.get(Uri.parse("$apiurl/search?q=$query"), headers: header);
    final Map<String, dynamic> jsonResponse = await json.decode(res.body);
    final data = [
      jsonResponse['data']['users'],
      jsonResponse['data']['posts'],
    ];

    if (res.statusCode == 200) {
      print('users Data is ${data[0]}');
      print('posts Data is ${data[1]}');
      return data;
    } else {
      return print(jsonResponse['message']);
    }
  }

// comments web service
  Future<dynamic> getComment(postId, int? pageid) async {
    var res = await http.get(
      Uri.parse("$apiurl/comments?post_id=$postId&page=$pageid"),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8'
      },
    );
    final Map<String, dynamic> map = await json.decode(res.body);
    final List<dynamic> data = map['data']['data'];
    if (res.statusCode == 200) {
      print(data);
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> getCommentPages(postId) async {
    var res = await http.get(
      Uri.parse("$apiurl/comments?post_id=$postId"),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8'
      },
    );
    final Map<String, dynamic> jsonResonse = await json.decode(res.body);
    final List<dynamic> data = jsonResonse['data'] as List;

    if (res.statusCode == 200) {
      print(data);
      return data.map((e) => Data.fromJson(e)).toList();
    } else {
      return data;
    }
  }

// add comment web service
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
    print(" ${res}");

    final data = await json.decode(res.body);
    if (res.statusCode == 200) {
      print(data);
      return data;
    } else {
      return data;
    }
  }

  // add follow web service

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
    print(" ${res.body}");

    final data = await json.decode(res.body);
    if (res.statusCode == 200) {
      print(data);
      return data;
    } else {
      return data;
    }
  }

// add like web service
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
    print(" ${res}");
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

  // add video web service

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
    print(" ${res}");

    final data = await json.decode(res.body);

    if (res.statusCode == 200) {
      print(data);
      return data;
    } else {
      return data;
    }
  }

  // get profile info web service

  Future<dynamic> getProfile(int? user_id) async {
    print(" ffffg ${SharedPrefrencesHelper.sharedPrefrencesHelper.getToken()}");
    var res = await http.get(
      Uri.parse("$apiurl/profile?user_id=$user_id"),
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

  // edit profile web service

  Future<dynamic> editProfile(
    String? name,
    String? description,
  ) async {
    var sendData = {
      "name": '$name',
      "description": '$description',
    };
    var res = await http.post(Uri.parse("$apiurl/profile"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8',
          'Authorization':
              'Bearer ${SharedPrefrencesHelper.sharedPrefrencesHelper.getToken()}',
          'Accept': 'application/json'
        },
        body: sendData);
    print(" ${res}");
    final data = await json.decode(res.body);
    if (res.statusCode == 200) {
      print(data);
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> uploadProfilePic(File imageFile) async {
    // open a bytestream
    var header = <String, String>{
      'Context-Type': 'application/json;charSet=UTF-8',
      'Authorization':
          'Bearer ${SharedPrefrencesHelper.sharedPrefrencesHelper.getToken()}',
      'Accept': 'application/json'
    };
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();
    final mimeTypeData =
        lookupMimeType(imageFile.path, headerBytes: [0xFF, 0xD8])?.split('/');

    // string to uri
    var uri = Uri.parse("$apiurl/profile");

    // create multipart request
    var request = http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = http.MultipartFile(
      'file',
      stream,
      length,
      filename: basename(imageFile.path),
      contentType: MediaType(mimeTypeData![0], mimeTypeData[1]),
    );

    // add file to multipart
    request.files.add(multipartFile);
    request.headers.addAll(header);

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  // get all chats

  Future<dynamic> getChats() async {
    var res = await http.get(
      Uri.parse("$apiurl/chats"),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8',
        'Authorization':
            'Bearer ${SharedPrefrencesHelper.sharedPrefrencesHelper.getToken()}',
        'Accept': 'application/json'
      },
    );
    final map = await json.decode(res.body);
    final data = map['data']['data'];
    if (res.statusCode == 200) {
      print(data);
      return data;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  // create new chat

  Future<dynamic> createChat({user_id}) async {
    var mydata = {
      "user_id": '$user_id',
    };
    var res = await http.post(Uri.parse("$apiurl/chats"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8',
          'Authorization':
              'Bearer ${SharedPrefrencesHelper.sharedPrefrencesHelper.getToken()}',
          'Accept': 'application/json'
        },
        body: mydata);

    final map = await json.decode(res.body);
    final data = map['data'];
    if (res.statusCode == 200) {
      print(data);
      return data;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  // get chat messages
   Future getChatMessages({chat_id, user_id}) async {
    http.Response res = await http.get(
      Uri.parse("$apiurl/messages?chat_id=$chat_id&user_id=$user_id"),
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8',
        'Authorization':
            'Bearer ${SharedPrefrencesHelper.sharedPrefrencesHelper.getToken()}',
        'Accept': 'application/json'
      },
    );
    final map = await json.decode(res.body);
    final data = map['data']['data'];
    if (res.statusCode == 200) {
      print(data);
      return data;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  // send message
  Future<dynamic> sendMessage({chat_id, message}) async {
    var mydata = {
      "chat_id": '$chat_id',
      "message": '$message',
    };
    var res = await http.post(Uri.parse("$apiurl/messages"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8',
          'Authorization':
              'Bearer ${SharedPrefrencesHelper.sharedPrefrencesHelper.getToken()}',
          'Accept': 'application/json'
        },
        body: mydata);
    var data = await json.decode(res.body);
    if (res.statusCode == 200) {
      print(data);
      return data;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  // upload video web service

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
      // final Map<String, dynamic> responseData = json.decode(response.body);
      // return responseData;
    } catch (e) {
      print(e);
    }
  }
}
