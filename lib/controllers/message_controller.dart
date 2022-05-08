
import 'package:get/get.dart';
import 'package:stream_master/models/message_model.dart';

import '../models/message_send_model.dart';

class MessageController extends GetxController{
RxList<ChatData> chatData = RxList<ChatData>([]) ;
RxList<MessageData> messageData = RxList<MessageData>([]) ;

  static MessageController get to => Get.find<MessageController>();

}