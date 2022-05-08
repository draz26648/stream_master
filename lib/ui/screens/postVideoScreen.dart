import 'dart:typed_data';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:stream_master/ui/screens/video_screen.dart';

import '../../api/stream_web_services.dart';

import '../../controllers/general_controller.dart';
import '../../utils.dart';

import '../widgets/constants.dart';

class PostVideoScreen extends StatefulWidget {
  final String? videoPath;

  const PostVideoScreen({
    Key? key,
    required this.videoPath,
  }) : super(key: key);

  @override
  _PostVideoScreen createState() => _PostVideoScreen();
}

class _PostVideoScreen extends State<PostVideoScreen> {
  bool isSwitchedComment = false;
  bool isSwitchedDuet = false;
  bool isSwitchedShare = false;
  var textValue = 'Switch is OFF';
  late TextEditingController _nameTextEditingController;

  @override
  void initState() {
    // TODO: implement initState
    _nameTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Share new Clip",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 77.47,
                    height: 109,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                        VideoPage(filePath: widget.videoPath!, isReview: false),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _nameTextEditingController,
                      style: TextStyle(color: Colors.grey, fontSize: 20.0),
                      autocorrect: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Some Text Here',
                        hintStyle:
                            TextStyle(fontSize: 20.0, color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.w),
                      child: Text(
                        'Allow comments',
                        style: TextStyle(color: Colors.black, fontSize: 15.sp),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10.0),
                      child: Transform.scale(
                        scale: 1.2,
                        child: Switch(
                          onChanged: toggleSwitch,
                          value: isSwitchedDuet,
                          activeColor: Colors.white,
                          activeTrackColor: Colors.green,
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey,
                        ),
                      ),
                    ),
                  ]),
            ),
            Container(
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Allow share',
                          style:
                              TextStyle(color: Colors.black, fontSize: 15.sp),
                        )),
                    Container(
                      margin: const EdgeInsets.only(right: 10.0),
                      child: Transform.scale(
                        scale: 1.2,
                        child: Switch(
                          onChanged: toggleSwitch2,
                          value: isSwitchedDuet,
                          activeColor: Colors.white,
                          activeTrackColor: Colors.green,
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey,
                        ),
                      ),
                    ),
                    // Align(alignment: Alignment.centerRight,
                  ]),
            ),
            Container(
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Allow duets',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )),
                    Container(
                      margin: const EdgeInsets.only(right: 10.0),
                      child: Transform.scale(
                        scale: 1.2,
                        child: Switch(
                          onChanged: toggleduet,
                          value: isSwitchedDuet,
                          activeColor: Colors.white,
                          activeTrackColor: Colors.green,
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey,
                        ),
                      ),
                    ),
                    // Align(alignment: Alignment.centerRight,
                  ]),
            ),
            SizedBox(
              height: 33.h,
            ),
            Container(
              margin: EdgeInsets.all(10.w),
              width: 343.w,
              height: 48.h,
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(0, 126.h),
                  backgroundColor: color2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0.r),
                  ),
                ),
                onPressed: () {
                  showLoaderDialog(context);
                  print("ffff ${GeneralDataController.to.videoPath?.path}");
                  Controller()
                      .uploadVideo(
                          postPath: GeneralDataController.to.videoPath,
                          title: "new post",
                          description: _nameTextEditingController.text)
                      .then((value) {
                    print("ff ${value}");
                    if (value['status'] == true) {
                      print("ff ${value}");
                      Navigator.of(context, rootNavigator: true).pop();
                      showAlertDialog(context, value['message']);
                    } else {
                      var snackBar = SnackBar(
                        content: Text("File Upload Failed"),
                      );
                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      // Navigator.pushReplacementNamed(context, "/Nav_screen");
                    }
                  });
                },
                child: Text(
                  'Post',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toggleSwitch(bool value) {
    if (isSwitchedComment == false) {
      setState(() {
        isSwitchedComment = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitchedComment = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  void toggleduet(bool value) {
    if (isSwitchedDuet == false) {
      setState(() {
        isSwitchedDuet = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitchedDuet = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  void toggleSwitch2(bool value) {
    if (isSwitchedShare == false) {
      setState(() {
        isSwitchedShare = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitchedShare = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }
}
