import 'package:get/get.dart';
import 'package:stream_master/api/stream_web_services.dart';

import '../models/Post.dart';

class VideoController extends GetxController {
  RxList<Data> postData = RxList<Data>([]);

  List<Data> get getvideo => postData.value;

  Controller? _controller;

  @override
  void onInit() {
    super.onInit();

    _controller!.getPost(1).then((value) {
      if (value != null) {
        postData = value['data'];
      }
      return postData;
    });
  }
}
