import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

// import 'package:flutter_tiktok/Common/Colors.dart';
// import 'package:flutter_tiktok/models/userModel.dart';
// import 'package:flutter_tiktok/pages/followersPage.dart';
// import 'package:flutter_tiktok/pages/userDetailPage.dart';
// import 'package:flutter_tiktok/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'dart:convert' as convert;

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../api/stream_web_services.dart';
import '../../get/profile_controller.dart';
import '../../models/profile.dart';

// import 'package:flutter_tiktok/other/bottomSheet.dart' as CustomBottomSheet;
// import 'EditProfilePage.dart';

class ProfilePage extends StatefulWidget {
  final bool canPop;
  final bool isSelfPage;
  final Function? onPop;
  final Function? onSwitch;

  const ProfilePage({
    Key? key,
    this.canPop: false,
    this.onPop,
    required this.isSelfPage,
    this.onSwitch,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // late UserModel model;
  var data;
  late VideoPlayerController _controller;

  var isloading = false;

  getProfile() async {
    setState(() {
      isloading = true;
    });
    try {
      Controller().getProfile().then((value) => {
            setState(() {
              isloading = false;
            }),
            if (value != null)
              {
                setState(() {
                  data = value['data'];
                  // return data;
                  // value.forEach((v) {
                  //   _tags.add(Post.fromJson(v));
                  // });
                }),
                ProfileController.to.data.value = Profile.fromJson(data),
                print("the data is ${data}"),
                // print("the data here is ${_tags[0].name}")
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
    getProfile();
    super.initState();
    print("init called");
    _controller = VideoPlayerController.network(
      '',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    // _controller.addListener(() {
    //   setState(() {});
    // });
    _controller.setLooping(true);
    _controller.initialize();
  }

  // @override
  // void didChangeDependencies() {
  //   print("did called");
  //   // data = loadJson();
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 8.h,
            backgroundColor: Colors.black,
          ),
          body: isloading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Obx((){
               // print("يييي ${ProfileController.to.data.value}") ;
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 15.w),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.r),
                            bottomRight: Radius.circular(15.r),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(15.r),
                                      child: Image.network(
                                        ProfileController.to.data.value.avatar!,
                                      ),
                                    ),
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 4,
                                          color: Colors.white),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            color: Colors.black
                                                .withOpacity(0.1),
                                            offset: Offset(0, 10))
                                      ],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['name'],
                                        style: TextStyle(
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 7.h,
                                      ),
                                      Text(
                                        '@${data['name']}',
                                        style: TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 110.w,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon:
                                    Image.asset('assets/images/scan.png'),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Image.asset(
                                        'assets/images/setting.png'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 47.w),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    child: Column(
                                      children: [
                                        Text(
                                          ProfileController.to.data.value.postsCount!,
                                          // data['posts_count'],
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          "Clipes",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight:
                                              FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    onTap: () {},
                                  ),
                                  Container(
                                    color: Colors.black54,
                                    width: 1,
                                    height: 15,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 15.w),
                                  ),
                                  InkWell(
                                      child: Column(
                                        children: [
                                          Text(
                                            '500',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight:
                                                FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            "Following",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight:
                                                FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      onTap: () {}),
                                  Container(
                                    color: Colors.black54,
                                    width: 1,
                                    height: 15,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 15),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        '1500',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Followes",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 16.h,
                                  right: 24.w,
                                  left: 24.w,
                                  bottom: 3.h),
                              child: Text(
                                'I enjoy photography and take pictures of food, people, products, architecture, landscapes, and portraits.I like to find beauty in the world, capture it and share it to brighten people',
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.white),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10.w),
                              width: double.infinity,
                              child: ElevatedButton(
                                style: TextButton.styleFrom(
                                  minimumSize: Size(0, 42.h),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(15.r),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/edit_profile_screen');
                                },
                                child: Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    /* SizedBox(
                                height: 25,
                              ),*/
                    Expanded(
                      child: Column(
                        children: [
                          TabBar(
                            // indicatorColor: MyColors.appcolor,
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            tabs: [
                              Tab(
                                icon: Image.asset('assets/images/clips.png'),
                              ),
                              Tab(
                                icon: Image.asset('assets/images/like.png'),
                              ),
                              Tab(
                                icon: Image.asset('assets/images/gift.png'),
                              ),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                GridView.builder(
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                                  // itemCount: model.videos!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                          child: _controller
                                              .value.isInitialized
                                              ? AspectRatio(
                                            aspectRatio:
                                            _controller.value
                                                .aspectRatio,
                                            child: VideoPlayer(
                                                _controller),
                                          )
                                              : Container(
                                            margin:
                                            EdgeInsets.all(
                                                35),
                                            child:
                                            CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                          height: 600.h,
                                          width: 113.w),
                                    );
                                  },
                                ),
                                GridView.builder(
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5),
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 600.h,
                                      width: 113.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        color: Colors.grey.shade50,
                                      ),
                                    );
                                  },
                                ),
                                Container(),
                                
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
          }


              ),
        ));
  }
}

class TextGroup extends StatelessWidget {
  final String title, tag;
  final Color? color;

  const TextGroup(
    this.title,
    this.tag, {
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            title,
           
          ),
          Container(width: 4),
          Text(
            tag,
           
          ),
        ],
      ),
    );
  }
}
