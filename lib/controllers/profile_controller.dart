import 'package:get/get.dart';

import '../models/profile.dart';

class ProfileController extends GetxController{
  Rx<UserData> data = UserData().obs;

  // static GeneralDataController _controller = GeneralDataController();

  static ProfileController get to => Get.find<ProfileController>();

}