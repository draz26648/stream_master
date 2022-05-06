import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:stream_master/helper/shared_prefrences_helper.dart';
import 'package:stream_master/models/Post.dart';
import 'package:stream_master/ui/screens/settings_screen.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_thumbnail_imageview/video_thumbnail_imageview.dart';

import '../../api/stream_web_services.dart';
import '../../controllers/general_controller.dart';
import '../../controllers/profile_controller.dart';

import '../../models/profile.dart';
import '../widgets/video_player_item.dart';

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
    this.onSwitch,
    required this.userId,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var data;
  List<dynamic>? userVideos;

  late VideoPlayerController _controller;

  var isloading = false;
  int? videoIndex;
  final ProfileController _profileController = ProfileController.to;
  final GeneralDataController _dataController = GeneralDataController.to;

  getProfile() async {
    setState(() {
      isloading = true;
    });
    try {
      await Controller().getProfile(widget.userId).then((value) => {
            setState(() {
              isloading = false;
            }),
            if (value != null)
              {
                setState(() {
                  data = value['data'];
                  _profileController.data.value = UserData.fromJson(data);
                }),
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

  getUserVideos() async {
    setState(() {
      isloading = true;
    });
    try {
      await Controller().getPost(0).then((element) {
        if (element != null) {
          print('profile videos is ${element}');
          setState(() {
            isloading = false;
          });
          setState(() {
            userVideos = element;
            for (var v in userVideos!) {
              _dataController.postData.value.add(Data.fromJson(v));
            }
          });
        }
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
    getUserVideos();
    super.initState();
    print("init called");
    _controller = VideoPlayerController.network(
      // videoUrl != null ?
      _dataController.postData.value[0].path!
      // : ''
      ,
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
                                                _profileController
                                                    .data.value.avatar!,
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
                                                  _profileController
                                                      .data.value.name!,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  height: 7.h,
                                                ),
                                                Text(
                                                  '@${_profileController.data.value.name!}',
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
                                          widget.isSelfPage
                                              ? IconButton(
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
                                                )
                                              : Container(),
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
                                                  _profileController
                                                      .data.value.postsCount!,
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
                                                    _profileController.data
                                                        .value.followersCount!,
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
                                                _profileController.data.value
                                                    .followingsCount!,
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
                                        child: widget.isSelfPage
                                            ? Text(
                                                'Edit Profile',
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              )
                                            : Text(
                                                _dataController
                                                        .postData
                                                        .value[0]
                                                        .user!
                                                        .isFollow!
                                                    ? 'Following'
                                                    : 'Follow',
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
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                TabBar(
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
                                      userVideos != null
                                          ? GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: .5,
                                                mainAxisSpacing: 2,
                                              ),
                                              itemCount: int.parse(
                                                  _profileController
                                                      .data.value.postsCount!),
                                              itemBuilder: (context, index) =>
                                                  buildPostItem(
                                                      _dataController.postData
                                                          .value[index].path!,
                                                      context),
                                            )
                                          : const Center(
                                              child: Text('there is no posts')),
                                      _profileController.data.value
                                                  .postFavoritesCount ==
                                              0
                                          ? const Center(
                                              child: Text(
                                                  'This services not available at this time'),
                                            )
                                          : GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      mainAxisSpacing: 5,
                                                      crossAxisSpacing: 2),
                                              itemCount: 5,
                                              itemBuilder: (context, index) {
                                                return buildPostItem(
                                                    _dataController.postData
                                                        .value[index].path!,
                                                    context);
                                              },
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

  Widget buildPostItem(String? videoUrl, BuildContext ctx) => Card(
        elevation: 0,
        child: Stack(children: [
          Container(
            height: 159,
            width: 113,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2.0),
              child: VTImageView(
                videoUrl: videoUrl!,
                width: 76.09,
                height: 109.0,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) {
                  return Container(
                    width: 76.09,
                    height: 109.0,
                    color: Colors.black,
                    child: Center(
                      child: Text("Image Loading Error"),
                    ),
                  );
                },
                assetPlaceHolder: 'asset/images/',
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              height: 20,
              width: 20,
              child: Icon(
                Icons.play_circle,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ]),
      );
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
