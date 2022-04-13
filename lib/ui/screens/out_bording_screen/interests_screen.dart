import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../api/stream_web_services.dart';
import '../../../get/general_controller.dart';
import '../../../helper/shared_prefrences_helper.dart';
import '../../../models/cat.dart';
import '../../widgets/constants.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({Key? key}) : super(key: key);

  @override
  _InterestsScreenState createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  late final List<Cat> _tags = [];
  List<Cat> interst = [];
  
  var data;

  bool isloading = false;
  
  getCat() async {
    setState(() {
      isloading = true;
    });
    try {
      Controller().getCategories().then((value) => {
            setState(() {
              isloading = false;
            }),
            if (value != null)
              {
                setState(() {
                  // data = value['data'];

                  value.forEach((v) {
                    _tags.add(Cat.fromJson(v));
                  });
                }),
                // print("the data is ${data}"),
                print("the data here is ${_tags[0].name}")
              }
            else
              {}
          });
    } catch (e) {
      print(e);
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  void initState() {
    SharedPrefrencesHelper.sharedPrefrencesHelper.setSeen("interestSeen",true);
    getCat();
    Future.delayed(const Duration(microseconds: 3), () {
      showAlertDialog(context);
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(left: 16.w, top: 46.3.h, bottom: 2.h),
                    child: Row(
                      children: [
                        Text(
                          'Your ',
                          style: TextStyle(
                            color: color1,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 32.sp,
                          ),
                        ),
                        Text(
                          'interests',
                          style: TextStyle(
                            color: color2,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 32.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      'Choose the type of videos you want to watch',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'poppins',
                        color: color1,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 36.h, left: 16.w, right: 16.w),
                    // padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 0,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runAlignment: WrapAlignment.center,
                      children: _tags
                          .map(
                            (tag) => InkWell(
                              child: Chip(
                                backgroundColor: tag.color,
                                elevation: 4,
                                label: Text(tag.name!),
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: tag.color == Colors.grey ?Colors.white:color1,
                                    fontSize: 12.sp,
                                    fontFamily: 'poppins'),

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                // onDeleted: () => deleteTag(targetTag: tag),
                              ),
                              onTap: () {
                                setState(() {
                                  if(tag.color == Colors.white){
                                    if(interst.length < 3){
                                      tag.color = Colors.grey;
                                      interst.add(tag);
                                    }
                                  }else{
                                    tag.color=Colors.white;
                                    interst.remove(tag);
                                  }
                                });
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 177.h, bottom: 12.h),
                    width: 343.w,
                    height: 48.h,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size(0, 126.h),
                        backgroundColor: interst.isEmpty ?color1.withOpacity(0.3): Color(0xff242424),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0.r),
                        ),
                      ),
                      onPressed: interst.isEmpty ? null :() {
                        var s ="";
                        print(interst[0].name);
                        interst.forEach((element) {
                          s = s+"${element.name},";
                        });
                        GeneralDataController.to.interest.value = s;
                        SharedPrefrencesHelper.sharedPrefrencesHelper.setData("interest",s);
                        Navigator.pushReplacementNamed(
                            context, '/gender_screen');
                      },
                      child: Text('Next'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.w),
                    width: 343.w,
                    height: 48.h,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size(0, 126.h),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0.r),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/gender_screen');
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(color: color2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
  showAlertDialog(BuildContext context) {
    Widget continueButton = Center(
      child: TextButton(
          child: Text(
            "Agree and Continue",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          }),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      backgroundColor: Color(0xffF2F2F2),
      content: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r),),
        child: Text(
          'By tapping " Agree and continue " , '
              'you agree to our Terms of Service and acknowledge that you have read our Privacy Policy to learn how we collect , use , and share your data . ',
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
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
