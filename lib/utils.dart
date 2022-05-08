import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'helper/shared_prefrences_helper.dart';

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;
File profilePhoto = File('');

pickImage(ImageSource source) async {
  final pickedImage = await ImagePicker().pickImage(source: source);
  if (pickedImage != null) {
    Get.snackbar('Profile Picture', 'Selected');
  }
  profilePhoto = File(pickedImage!.path);
  return profilePhoto;
}

checkLogin(context, doTask ) async {
  if (SharedPrefrencesHelper.sharedPrefrencesHelper.getLogin() != null &&
      SharedPrefrencesHelper.sharedPrefrencesHelper.getLogin()!) {

    doTask();
    return true;
  } else {
    Navigator.pushNamed(context, '/Sign_in');
    return false;
  }
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialog(BuildContext context, String text) {
  Widget continueButton = Center(
    child: TextButton(
        child: Text(
          "OK",
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
        }),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: Color(0xffF2F2F2),
    content: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17.r),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14.sp,
          fontFamily: 'poppins',
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
    actions: [
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
