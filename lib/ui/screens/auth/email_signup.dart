import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../api/stream_web_services.dart';

import '../../../controllers/general_controller.dart';
import '../../../helper/shared_prefrences_helper.dart';
import '../../../utils.dart';
import '../../widgets/constants.dart';

class EmailSignUp extends StatefulWidget {
  const EmailSignUp({Key? key}) : super(key: key);

  @override
  _EmailSignUpState createState() => _EmailSignUpState();
}

class _EmailSignUpState extends State<EmailSignUp> {
  bool _isObscure = true;

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmController;
  late GeneralDataController controller;

  var data;
  var isloading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmController = TextEditingController();
    controller = GeneralDataController.to;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                        Navigator.pop(context);
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
                            'SignUp',
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
                            'Enter your email address and we will send you a confirm code',
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
                              top: 24.h, left: 16.w, bottom: 10.h),
                          child: Text(
                            'Full Name',
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
                            controller: _nameController,
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
                          child: TextFormField(
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
                          child: TextFormField(
                            obscureText: _isObscure,
                            controller: _passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              } else if (value.length < 8) {
                                return 'Password must be atleast 8 characters';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              hintStyle: const TextStyle(fontFamily: 'Poppins'),
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
                            'Confirm Password',
                            style: TextStyle(
                              color: color2,
                              fontFamily: 'poppins',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 16.w, right: 16.w, top: 10.h),
                          child: TextFormField(
                            obscureText: _isObscure,
                            controller: _confirmController,
                            validator: (value) {
                              if (value! == _passwordController.text) {
                                return 'Password does not match';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0),
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
                              // setState(() {
                              //   isloading = true;
                              // });
                              var name = _nameController.text;
                              var email = _emailController.text;
                              var password = _passwordController.text;
                              var confirm = _confirmController.text;

                              Controller()
                                  .register(
                                      name: name,
                                      email: email,
                                      password: password,
                                      confirmPassword: confirm,
                                      mobile: "",
                                      interests: controller.interest,
                                      gender: controller.gender,
                                      birthdate: controller.date)
                                  .then((value) {
                                print("Register ${value}");

                                if (value['status'] != true) {
                                  Fluttertoast.showToast(msg: value['message']);
                                } else {
                                  Fluttertoast.showToast(msg: value['message']);
                                  SharedPrefrencesHelper.sharedPrefrencesHelper
                                      .setIsLogin(true);
                                  SharedPrefrencesHelper.sharedPrefrencesHelper
                                      .setToken(value['data']['token']);
                                  Navigator.pushReplacementNamed(
                                      context, '/congrats_screen');
                                  
                                }
                              });

                              // Navigator.pushReplacementNamed(context, '/congrats_screen');
                            },
                            child: Text(
                              'Sign up',
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
                ],
              ),
            ),
    );
  }

  showLoaderDialog(BuildContext context) {
    const CircularProgressIndicator(
      color: Colors.black,
    );
  }

  // Future<void> performRegister() async {
  //   if (checkData()) {
  //     await register();
  //   }
  // }
  //
  // bool checkData() {
  //   if (_passwordTextEditingController.text.isNotEmpty &&
  //       _nameTextEditingController.text.isNotEmpty &&
  //       _passwordTextEditingController.text.isNotEmpty
  //       ) {
  //     return true;
  //   }
  //   showSnackBar(
  //     context,
  //     message: 'Enter required data!',
  //     error: true,
  //   );
  //   return false;
  // }
  //
  // Future<void> register() async {
  //   bool status = await AuthApiController().register(context, user: user);
  //
  //   // if (status) {
  //   //   Navigator.push(
  //   //     context,
  //   //     MaterialPageRoute(
  //   //       builder: (context) =>
  //   //           VerifyCode(phone: _phoneTextEditingController.text),
  //   //     ),
  //   //   );
  //   // }
  // }
  //
  // RegisterUser get user {
  //   RegisterUser user = RegisterUser();
  //   user.name = _nameTextEditingController.text;
  //   user.password = _passwordTextEditingController.text;
  //   user.mobile = _emailTextEditingController.text;
  //
  //   return user;
  // }
}
