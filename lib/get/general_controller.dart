// import 'dart:html';

import 'dart:io';

import 'package:get/get.dart';
import 'package:stream_master/models/Post.dart';

class GeneralDataController extends GetxController{
  RxString interest ="".obs;
  RxInt gender = 0.obs;
  RxString date = "".obs;
  RxList<Data> postData = RxList<Data>([]) ;
  File? videoPath ;






  static GeneralDataController get to => Get.find<GeneralDataController>();

  changeFavoriteState(int index){
    postData.value[index].isFavorite = !postData.value[index].isFavorite!;
    refresh();
  }

  changeIsFollowState(int index){
    postData.value[index].user!.isFollow = !postData.value[index].user!.isFollow!;
    refresh();
  }

}