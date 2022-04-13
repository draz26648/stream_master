import 'package:get/get.dart';

import '../models/profile.dart';

class ProfileController extends GetxController{
  Rx<Profile> data = Profile().obs;

  // static GeneralDataController _controller = GeneralDataController();

  static ProfileController get to => Get.find<ProfileController>();

}