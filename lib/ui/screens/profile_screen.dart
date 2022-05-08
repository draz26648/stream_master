import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:stream_master/helper/shared_prefrences_helper.dart';
import 'package:stream_master/models/Post.dart';
import 'package:stream_master/ui/screens/qr_screen.dart';
import 'package:stream_master/ui/screens/settings_screen.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_thumbnail_imageview/video_thumbnail_imageview.dart';

import '../../api/stream_web_services.dart';
import '../../controllers/general_controller.dart';
import '../../controllers/profile_controller.dart';

import '../../models/profile.dart';
import '../widgets/video_player_item.dart';
import 'chat/chat_screen.dart';
import 'main_widgets/app_loader.dart';

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
  int currentIndex = 0;
  onTap(index) {
    if (mounted) {
      setState(() {
        currentIndex = index;
      });
    }
  }

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

  int? chatId;
  createChat() async {
    try {
      await Controller()
          .createChat(
        user_id: widget.userId,
      )
          .then((value) {
        if (value != null) {
          setState(() {
            chatId = value['id'];
          });
        }
      });
    } catch (e) {
      print(e);
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
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          image: AssetImage('assets/images/stack.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: AppLoader(),
                      ),
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
                                          widget.isSelfPage
                                              ? Container()
                                              : IconButton(
                                                  onPressed: () async{
                                                  await  createChat();
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                ChatScreen(
                                                                  chatId:
                                                                      chatId!,
                                                                  userId: widget
                                                                      .userId!,
                                                                )));
                                                  },
                                                  icon: const ImageIcon(
                                                    AssetImage(
                                                        'assets/images/chat.png'),
                                                    color: Colors.white,
                                                  )),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) => QRScreen(
                                                            image:
                                                                _profileController
                                                                    .data
                                                                    .value
                                                                    .avatar!,
                                                          )));
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
                                      child: _profileController
                                                  .data.value.description !=
                                              null
                                          ? Text(
                                              _profileController
                                                  .data.value.description!,
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: Colors.white),
                                            )
                                          : Text(
                                              'No description',
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
                                          if (widget.isSelfPage) {
                                            Navigator.pushNamed(context,
                                                '/edit_profile_screen');
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Followed");
                                          }
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
                                                _profileController
                                                        .data.value.isFollow!
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
                                        icon: currentIndex == 0
                                            ? Image.asset(
                                                'assets/images/clips.png')
                                            : Image.asset(
                                                'assets/images/declips.png',
                                              )),
                                    Tab(
                                      icon: currentIndex == 1
                                          ? Image.asset(
                                              'assets/images/like.png')
                                          : Image.asset(
                                              'assets/images/delike.png'),
                                    ),
                                    Tab(
                                        icon: currentIndex == 2
                                            ? Image.asset(
                                                'assets/images/gift.png')
                                            : Image.asset(
                                                'assets/images/gift.png',
                                                color: Colors.grey,
                                              )),
                                  ],
                                  onTap: (index) {
                                    onTap(index);
                                  },
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
                                                  InkWell(
                                                onTap: () {},
                                                child: buildPostItem(
                                                    _dataController.postData
                                                        .value[index].path!,
                                                    context),
                                              ),
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
                assetPlaceHolder: '',
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
