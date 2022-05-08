import 'package:get/get.dart';

import '../models/chats_model.dart';

class ChatController extends GetxController {
  RxList<GeneralChats> chats = RxList<GeneralChats>([]);
  static ChatController get to => Get.find<ChatController>();
}
