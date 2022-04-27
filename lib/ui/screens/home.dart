import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:share_plus/share_plus.dart';

import 'package:stream_master/ui/screens/comment_screen.dart';
import 'package:stream_master/ui/screens/profile_screen.dart';
import 'package:video_player/video_player.dart';

import '../../api/stream_web_services.dart';

import '../../constant.dart';
import '../../controllers/general_controller.dart';
import '../../controllers/video_controller.dart';
import '../../models/Post.dart';
import '../../utils.dart';
import '../widgets/video_player_item.dart';
import '../screens/screens.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<dynamic> data;
  String likeCount = '0';

  bool isloading = false;



  final GeneralDataController _controller = GeneralDataController.to;

  // final VideoController _videoController = VideoController();

  getPost() async {
    setState(() {
      isloading = true;
    });
    try {
      Controller().getPost().then((value) => {
            setState(() {
              isloading = false;
            }),
            if (value != null)
              {
                setState(() {
                  data = value;

                  data.forEach((element) {
                    // ignore: invalid_use_of_protected_member
                    _controller.postData.value.add(Data.fromJson(element));
                  });
                }),
                print(
                    // ignore: invalid_use_of_protected_member
                    "the data is ${_controller.postData.value[0].toString()}"),
              }
            else
              {
                print('there is no data here'),
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
    getPost();
    super.initState();
  }

  Color color = Colors.white;

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(11),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.grey,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: AssetImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ))
        ],
      ),
    );
  }

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: AssetImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 2,
            left: 23,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 8,
              child: Icon(
                Icons.add,
                size: 10,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        extendBody: true,
        body: isloading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Obx(() {
                print("data length is  ${_controller.postData.value.length}");
                return PageView.builder(
                    itemCount: _controller.postData.value.length,
                    controller:
                        PageController(initialPage: 0, viewportFraction: 1),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          VideoPlayerItem(
                            videoUrl: _controller.postData.value[index].path!,
                            
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 100),
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 16.w),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              '@${_controller.postData.value[index].user!.name!}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
                                                fontFamily: 'poppins',
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(height: 10.h),
                                            Text(
                                              // ignore: invalid_use_of_protected_member
                                              _controller.postData.value[index]
                                                  .description!,
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'poppins',
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(height: 14.h),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/music.png',
                                                  width: 30.w,
                                                  height: 30.h,
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Text(
                                                  _controller.postData
                                                      .value[index].title!,
                                                  style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'poppins',
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              InkWell(
                                                child: Container(
                                                  width: 55.w,
                                                  height: 55.h,
                                                  child: Stack(
                                                    children: [
                                                      InkWell(
                                                        child: Container(
                                                          height: 50.h,
                                                          width: 50.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white),
                                                            shape:
                                                                BoxShape.circle,
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    _controller
                                                                        .postData
                                                                        .value[
                                                                            index]
                                                                        .user!
                                                                        .avatar!),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      ProfilePage(
                                                                        isSelfPage:
                                                                            false,
                                                                      )));
                                                        },
                                                      ),
                                                      Positioned(
                                                        bottom: 0,
                                                        left: 18.w,
                                                        // child: InkWell(
                                                        //   onTap: () {
                                                        //     checkLogin(
                                                        //         context, () {
                                                        //       Controller()
                                                        //           .addFllow(
                                                        //               user_id: _controller
                                                        //                   .postData
                                                        //                   .value[
                                                        //                       index]
                                                        //                   .user!
                                                        //                   .id)
                                                        //           .then(
                                                        //               (value) {
                                                        //         if (value[
                                                        //                 'status'] !=
                                                        //             true) {
                                                        //           showAlertDialog(
                                                        //               context,
                                                        //               value[
                                                        //                   'message']);
                                                        //         } else {
                                                        //           _controller
                                                        //               .changeIsFollowState(
                                                        //                   index);
                                                        //         }
                                                        //       });
                                                        //     });
                                                        //   },
                                                        //   child: Visibility(
                                                        //     visible:
                                                        //         _controller
                                                        //             .postData
                                                        //             .value[
                                                        //                 index]
                                                        //             .user!
                                                        //             .isFollow!,
                                                        //     child: Container(
                                                        //       width: 20.w,
                                                        //       height: 20.h,
                                                        //       decoration: const BoxDecoration(
                                                        //           shape: BoxShape
                                                        //               .circle,
                                                        //           color: Colors
                                                        //               .blue),
                                                        //       child:
                                                        //           const Center(
                                                        //         child: Icon(
                                                        //           Icons.add,
                                                        //           color: Colors
                                                        //               .white,
                                                        //           size: 15,
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                        child: Container(
                                                          width: 20.w,
                                                          height: 20.h,
                                                          decoration:
                                                              const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .blue),
                                                          child: Center(
                                                            child: LikeButton(
                                                              onTap: (bool
                                                                  isFollowed) async {
                                                                await checkLogin(
                                                                    context,
                                                                    () {
                                                                  Controller()
                                                                      .addFllow(
                                                                          user_id: _controller
                                                                              .postData
                                                                              .value[index]
                                                                              .user!
                                                                              .id)
                                                                      .then((value) {
                                                                    if (value[
                                                                            'status'] !=
                                                                        true) {
                                                                      showAlertDialog(
                                                                          context,
                                                                          value[
                                                                              'message']);
                                                                    } else {
                                                                      _controller
                                                                          .changeIsFollowState(
                                                                              index);
                                                                    }
                                                                  });
                                                                });

                                                                return !isFollowed;
                                                              },
                                                              size: 17,
                                                              circleColor: const CircleColor(
                                                                  start: Color(
                                                                      0xff00ddff),
                                                                  end: Color(
                                                                      0xff0099cc)),
                                                              bubblesColor:
                                                                  const BubblesColor(
                                                                dotPrimaryColor:
                                                                    Color(
                                                                        0xff33b5e5),
                                                                dotSecondaryColor:
                                                                    Color(
                                                                        0xff0099cc),
                                                              ),
                                                              likeBuilder: (bool
                                                                  isFollowed) {
                                                                return Icon(
                                                                  isFollowed &&
                                                                  _controller
                                                                              .postData
                                                                              .value[
                                                                                  index]
                                                                              .user!
                                                                              .isFollow! ==
                                                                          true
                                                                      ? Icons
                                                                          .done
                                                                      : Icons
                                                                          .add,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 15,
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20.h),
                                              Column(
                                                children: [
                                                  LikeButton(
                                                    onTap:
                                                        (bool isLiked) async {
                                                      await checkLogin(context,
                                                          () {
                                                            
                                                        Controller()
                                                            .addLike(
                                                                post_id:
                                                                    _controller
                                                                        .postData
                                                                        .value[
                                                                            index]
                                                                        .id)
                                                            .then((value) {
                                                          if (value['status'] !=
                                                              true) {
                                                            showAlertDialog(
                                                                context,
                                                                value[
                                                                    'message']);
                                                          } else {
                                                            _controller
                                                                .changeFavoriteState(
                                                                    index);
                                                          }
                                                        });
                                                      });

                                                      return !isLiked;
                                                    },
                                                    countPostion:
                                                        CountPostion.bottom,
                                                    size: 30,
                                                    circleColor:
                                                        const CircleColor(
                                                            start: Color(
                                                                0xff00ddff),
                                                            end: Color(
                                                                0xff0099cc)),
                                                    bubblesColor:
                                                        const BubblesColor(
                                                      dotPrimaryColor:
                                                          Color(0xff33b5e5),
                                                      dotSecondaryColor:
                                                          Color(0xff0099cc),
                                                    ),
                                                    likeBuilder:
                                                        (bool isLiked) {
                                                      return Icon(
                                                        Icons.favorite,
                                                        color: isLiked &&
                                                                _controller
                                                                        .postData
                                                                        .value[
                                                                            index]
                                                                        .isFavorite ==
                                                                    true
                                                            ? Colors.red
                                                            : Colors.grey,
                                                        size: 30,
                                                      );
                                                    },
                                                    likeCount: int.parse(
                                                        _controller
                                                            .postData
                                                            .value[index]
                                                            .favoritesCount!),
                                                    countBuilder: (int? count,
                                                        bool isLiked,
                                                        String text) {
                                                      var color = isLiked
                                                          ? Colors.red
                                                          : Colors.grey;
                                                      Widget result;
                                                      if (count == 0) {
                                                        result = const Text(
                                                          "Like",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        );
                                                      } else {
                                                        result = Text(
                                                          text,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        );
                                                      }
                                                      return result;
                                                    },
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 20.h),
                                              InkWell(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (context) =>
                                                        CommentScreen(
                                                            _controller
                                                                .postData
                                                                .value[index]
                                                                .id,
                                                            _controller
                                                                .postData
                                                                .value[index]
                                                                .commentsCount),
                                                  );
                                                },
                                                child: Column(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/messege.png',
                                                      width: 40.h,
                                                      height: 40.h,
                                                      color: Colors.grey[400],
                                                    ),
                                                    Text(
                                                      _controller
                                                          .postData
                                                          .value[index]
                                                          .commentsCount
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 10.sp,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 20.h),
                                              InkWell(
                                                onTap: () async {
                                                  final urlPreview = _controller
                                                      .postData
                                                      .value[index]
                                                      .path;
                                                  await Share.share(
                                                      '$urlPreview');
                                                },
                                                child: Column(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/share.png',
                                                      width: 35.h,
                                                      height: 35.h,
                                                      color: Colors.grey[400],
                                                    ),
                                                    Text(
                                                      '0',
                                                      style: TextStyle(
                                                          fontSize: 10.sp,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    });
              }));
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

  @override
  void dispose() {
    // TODO: implement dispose
    // _controller.dispose();
    super.dispose();
  }
}
