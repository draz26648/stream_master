import 'package:get/get.dart';

import '../models/profile.dart';

class ProfileController extends GetxController{
  Rx<Data> data = Data().obs;

  // static GeneralDataController _controller = GeneralDataController();

  static ProfileController get to => Get.find<ProfileController>();

}