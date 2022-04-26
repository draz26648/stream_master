import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_master/ui/screens/auth/selected_method.dart';

import '../../widgets/constants.dart';

class SignUpMethods extends StatefulWidget {
  const SignUpMethods({Key? key}) : super(key: key);

  @override
  _SignUpMethodsState createState() => _SignUpMethodsState();
}

class _SignUpMethodsState extends State<SignUpMethods> {
  SelectedMethod? _method;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color2,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/stack.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16.w, top: 148.h),
                  child: Text(
                    'Let’s get started',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'poppins',
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16.w),
                  child: Text(
                    'Singing up or login to see our top picks for your',
                    style: TextStyle(
                        color: Color(0xff909090),
                        fontFamily: 'poppins',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 230.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14.r),
                  topLeft: Radius.circular(14.r),
                ),
              ),
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/phone_signUp');
                    },
                    child: Container(
                      width: 343.w,
                      height: 45.h,
                      margin:
                          EdgeInsets.only(top: 24.h, left: 20.w, right: 20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: Color(0xffE7E7E7),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/byphone.png',
                                  width: 24.w,
                                  height: 24.h,
                                ),
                                Text(
                                  ' |',
                                  style:
                                      TextStyle(fontSize: 24.sp, color: color1),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 100.w,
                          ),
                          Text(
                            'By Phone number',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/birth_date');
                    },
                    child: Container(
                      width: 343.w,
                      height: 45.h,
                      margin:
                          EdgeInsets.only(top: 24.h, left: 20.w, right: 20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: Color(0xffE7E7E7),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/byemail.png',
                                  width: 24.w,
                                  height: 24.h,
                                ),
                                Text(
                                  ' |',
                                  style:
                                      TextStyle(fontSize: 24.sp, color: color1),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 100.w,
                          ),
                          Text(
                            'By email address',
                            style: TextStyle(
                                fontSize: 14.sp, fontFamily: 'poppins'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/birth_date');
                    },
                    child: Container(
                      width: 343.w,
                      height: 45.h,
                      margin:
                          EdgeInsets.only(top: 24.h, left: 20.w, right: 20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: Color(0xffE7E7E7),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/bygoogle.png',
                                  width: 24.w,
                                  height: 24.h,
                                ),
                                Text(
                                  ' |',
                                  style:
                                      TextStyle(fontSize: 24.sp, color: color1),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 100.w,
                          ),
                          Text(
                            'Continue with Google',
                            style: TextStyle(
                                fontSize: 14.sp, fontFamily: 'poppins'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 90.w, vertical: 14.h),
                    child: Row(
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Already have an account?',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: color1,
                              fontFamily: 'poppins',
                              fontSize: 12.sp,
                            ),
                            children: [
                              const TextSpan(text: ' '),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      Navigator.pushNamed(context, '/Sign_in'),
                                text: 'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                  fontFamily: 'poppins',
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {},
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text(
          "Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
