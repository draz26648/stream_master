import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:stream_master/helper/shared_prefrences_helper.dart';
import 'package:stream_master/ui/screens/settings_screen.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../api/stream_web_services.dart';
import '../../controllers/profile_controller.dart';

import '../../models/profile.dart';

class ProfilePage extends StatefulWidget {
  final int? userId;
  final bool canPop;
  final bool isSelfPage;
  final Function? onPop;
  final Function? onSwitch;

  const ProfilePage({
    Key? key,
    this.canPop: false,
    this.onPop,
    required this.isSelfPage,
    this.onSwitch, required this.userId,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // int? userId;
  //
  // late List<Data> fetchProfile = [];
  var data;

  late VideoPlayerController _controller;

  var isloading = false;

  getProfile() async {
    setState(() {
      isloading = true;
    });
    try {
      Controller().getProfile(widget.userId).then((value) => {
            setState(() {
              isloading = false;
            }),
            if (value != null)
              {
                setState(() {
                  data = value['data'];
                }),
                ProfileController.to.data.value = Data.fromJson(data),
                print("the data is ${data}"),
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

    _controller.setLooping(true);
    _controller.initialize();
  }

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
          body: SharedPrefrencesHelper.sharedPrefrencesHelper.getToken() != null
              ? isloading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Obx(() {
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
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                              child: Image.network(
                                                ProfileController
                                                    .to.data.value.avatar!,
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
                                          Expanded(
                                            child: Column(
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
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      'this service is not available at this time');
                                            },
                                            icon: Image.asset(
                                                'assets/images/scan.png'),
                                          ),
                                        widget.isSelfPage?  IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          SettingsScreen()));
                                            },
                                            icon: Image.asset(
                                              'assets/images/setting.png',
                                            ),
                                          ) : Container(),
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
                                                  ProfileController.to.data
                                                      .value.postsCount!,
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
                                            color: Colors.white,
                                            width: 1.5,
                                            height: 15,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15.w),
                                          ),
                                          InkWell(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    data['followings_count'],
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
                                            color: Colors.white,
                                            width: 1.5,
                                            height: 15,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                data['followers_count'],
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Followers",
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
                                  widget.isSelfPage? Container(
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
                                    ):Container(),
                                  ],
                                ),
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
                                        icon: Image.asset(
                                            'assets/images/clips.png')),
                                    Tab(
                                      icon:
                                          Image.asset('assets/images/like.png'),
                                    ),
                                    Tab(
                                        icon: Image.asset(
                                            'assets/images/gift.png')),
                                  ],
                                  onTap: (index) {},
                                ),
                                Expanded(
                                  child: TabBarView(
                                    children: [
                                      data['posts_count'] != 0
                                          ? GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                              ),
                                              // itemCount: model.videos!.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Container(
                                                      child: _controller.value
                                                              .isInitialized
                                                          ? AspectRatio(
                                                              aspectRatio:
                                                                  _controller
                                                                      .value
                                                                      .aspectRatio,
                                                              child: VideoPlayer(
                                                                  _controller),
                                                            )
                                                          : Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(35),
                                                              child:
                                                                  const CircularProgressIndicator(
                                                                strokeWidth: 2,
                                                              ),
                                                            ),
                                                      height: 600.h,
                                                      width: 113.w),
                                                );
                                              },
                                            )
                                          : const Center(
                                              child: Text('there is no post')),
                                      data['post_favorites_count'] == 0
                                          ? GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
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
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.grey.shade50,
                                                  ),
                                                );
                                              },
                                            )
                                          : const Center(
                                              child: Text(
                                                  'This services not available at this time'),
                                            ),
                                      const Center(
                                        child: Text(
                                            'This services not available at this time'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    })
              : const Center(
                  child: Text('Please login to see your profile'),
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
