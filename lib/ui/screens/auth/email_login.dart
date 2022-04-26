import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_master/models/login_model.dart';

import '../../../api/stream_web_services.dart';
import '../../../helper/shared_prefrences_helper.dart';
import '../../../utils.dart';
import '../../widgets/constants.dart';

class EmailSignIn extends StatefulWidget {
  const EmailSignIn({Key? key}) : super(key: key);

  @override
  _EmailSignInState createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {
  bool _isObscure = true;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  var data;
  var isloading = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: color2,
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/stack.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50.h, left: 19),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/Nav_screen');
                      },
                      icon: const Icon(
                        Icons.keyboard_backspace,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 110.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(14.r),
                        topLeft: Radius.circular(14.r),
                      ),
                    ),
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 24.h, left: 16.w),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: color2,
                              fontFamily: 'poppins',
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 24.h, left: 16.w, right: 122.w),
                          child: Text(
                            'Enter your email address and password',
                            style: TextStyle(
                              color: color1,
                              fontFamily: 'poppins',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 10.h, left: 16.w, bottom: 10.h),
                          child: Text(
                            'Email Address',
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
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
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
                            controller: _passwordController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
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
                          margin: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 24.h),
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
                              var email = _emailController.text;
                              var password = _passwordController.text;
                              // print(email+password);
                              Controller()
                                  .Login(email: email, password: password)
                                  .then((value) {
                                if (value['status'] != true) {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();

                                  showAlertDialog(context, value.message!);
                                } else {
                                  SharedPrefrencesHelper.sharedPrefrencesHelper
                                      .setIsLogin(true);
                                  SharedPrefrencesHelper.sharedPrefrencesHelper
                                      .setToken(value['data']['token']);
                                  Navigator.pushReplacementNamed(
                                      context, '/Nav_screen');
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                }
                              });
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'poppins',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 90.w, vertical: 14.h),
                          child: Row(
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'Dont have an account?',
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
                                            Navigator.pushReplacementNamed(
                                                context, '/birth_date'),
                                      text: 'SignUp',
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

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
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
}
