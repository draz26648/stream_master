import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';


import '../../api/stream_web_services.dart';
import '../../get/profile_controller.dart';
import '../../utils.dart';
import '../widgets/constants.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameTextEditingController;
  late TextEditingController _userNameTextEditingController;
  late TextEditingController _emailTextEditingController;
  late TextEditingController _mobileTextEditingController;
  final ProfileController _controller = ProfileController.to;

  File? _image;

  bool _isObscure = true;

  late TextEditingController _passwordTextEditingController;

  @override
  void initState() {
    
    _nameTextEditingController = TextEditingController();
    _userNameTextEditingController = TextEditingController();
    _nameTextEditingController.text = _controller.data.value.name!;
    _userNameTextEditingController.text = '@' + _controller.data.value.name!;
    _emailTextEditingController = TextEditingController();
    _emailTextEditingController.text = "";
    _emailTextEditingController.text = _controller.data.value.email!;
    _mobileTextEditingController = TextEditingController();
    _mobileTextEditingController.text = _controller.data.value.mobile!;
    _passwordTextEditingController = TextEditingController();
    _passwordTextEditingController.text = "";
    super.initState();
  }

  Future chooseFile() async {
    final ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = File(image!.path);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75.h,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.r),
            bottomRight: Radius.circular(15.r),
          ),
        ),
        backgroundColor: Colors.black,
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 120.w,
                height: 120.h,
                child: Stack(
                  children: [
                    Container(
                      height: 110.h,
                      width: 110.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        backgroundImage: _image!= null ?FileImage(_image!):NetworkImage(_controller.data.value.avatar!) as ImageProvider,
                        // child: Image.network(
                        //   _controller.data.value.avatar!,
                        //   fit: BoxFit.fill,
                        //   width: 110.w,
                        //   height: 110.h,
                        // ),
                      ),
                    ),
                    Positioned(
                      right: 30.w,
                      bottom: 0,
                      left: 30.w,
                      child: InkWell(
                        onTap: () {
                          chooseFile();
                        },
                        child: Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Center(
                            child: Image.asset(
                              'assets/images/group.png',
                              width: 40.w,
                              height: 40.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 24.h, left: 16.w, bottom: 10.h),
              child: Text(
                'Name',
                style: TextStyle(
                  color: color2,
                  fontFamily: 'poppins',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16.w, right: 16.w),
              child: TextField(
                controller: _nameTextEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  hintStyle: TextStyle(fontFamily: 'Poppins'),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: color1,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: color1,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),

                  // focusedBorder: border(borderColor: Colors.white)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.h, left: 16.w, bottom: 10.h),
              child: Text(
                'User Name',
                style: TextStyle(
                  color: color2,
                  fontFamily: 'poppins',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16.w, right: 16.w),
              child: TextField(
                controller: _userNameTextEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  hintStyle: TextStyle(fontFamily: 'Poppins'),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: color1,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: color1,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),

                  // focusedBorder: border(borderColor: Colors.white)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.h, left: 16.w),
              child: Text(
                'email Adress',
                style: TextStyle(
                  color: color2,
                  fontFamily: 'poppins',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16.w, right: 16.w),
              child: TextField(
                controller: _emailTextEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  hintStyle: TextStyle(fontFamily: 'Poppins'),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: color1,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: color1,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),

                  // focusedBorder: border(borderColor: Colors.white)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.h, left: 16.w),
              child: Text(
                'Mobile Number',
                style: TextStyle(
                  color: color2,
                  fontFamily: 'poppins',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16.w, right: 16.w),
              child: TextField(
                controller: _mobileTextEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  hintStyle: TextStyle(fontFamily: 'Poppins'),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: color1,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: color1,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),

                  // focusedBorder: border(borderColor: Colors.white)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.h, left: 16.w),
              child: Text(
                'Password',
                style: TextStyle(
                  color: color2,
                  fontFamily: 'poppins',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16.w, right: 16.w),
              child: TextField(
                obscureText: _isObscure,
                controller: _passwordTextEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                  contentPadding:
                  EdgeInsets.fromLTRB(10, 10, 10, 0),
                  hintStyle: TextStyle(fontFamily: 'Poppins'),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: color1,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: color1,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),

                  // focusedBorder: border(borderColor: Colors.white)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              width: 343.w,
              height: 48.h,
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(0, 126.h),
                  backgroundColor: const Color(0xff242424),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0.r),
                  ),
                ),
                onPressed: () {
                  showLoaderDialog(context);
                  Controller().editProfile(
                          _image!,
                          name: _nameTextEditingController.text,
                          email: _emailTextEditingController.text,
                          mobile: _mobileTextEditingController.text,
                          description: "",
                          password: _passwordTextEditingController.text).then((value) {
                    if (value.containsKey("message")) {
                      Navigator.of(context, rootNavigator: true).pop();
                      showAlertDialog(context, value['message']);
                      // var snackBar = SnackBar(content: Text(value['message']),);
                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      Navigator.of(context, rootNavigator: true).pop();
                      var snackBar = SnackBar(
                        content: Text(
                          "profile update sucessfully",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white,fontSize: 18,),
                        ),
                        backgroundColor: Colors.green,
                        // margin: EdgeInsets.all(8),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                  // Navigator.pushReplacementNamed(context, '/congrats_screen');
                },
                child: Text(
                  'save',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'poppins',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
