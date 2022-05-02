import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  int currentPage = 1;
  int currentVideo = 0;
  int maxPage = 4;

  final GeneralDataController _controller = GeneralDataController.to;

  // final VideoController _videoController = VideoController();

  getPost() async {
    setState(() {
      isloading = true;
    });
    try {
      Controller().getPost(currentPage).then((value) => {
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
      Controller().getPostPages().then((value) => {
            setState(() {
              maxPage = int.parse(value['last_page']);
            }),
          });
    } catch (e) {
      print(e);
      setState(() {
        isloading = false;
      });
    }
  }

  PageController scrollController =
      PageController(initialPage: 0, viewportFraction: 1);

  @override
  void initState() {
    getPost();
    super.initState();
    scrollController.addListener(() {
      setState(() {
        currentVideo = scrollController.page!.toInt();
      });
      if (currentVideo >= 5 && currentPage < maxPage) {
        setState(() {
          currentPage++;
          getPost();
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Color color = Colors.white;
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
              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                        itemCount: _controller.postData.value.length,
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              InkWell(
                                onDoubleTap: () async {
                                  // await checkLogin(context, () {
                                  //   Controller()
                                  //       .addLike(
                                  //           post_id: _controller
                                  //               .postData.value[index].id)
                                  //       .then((value) {
                                  //     if (value['status'] != true) {
                                  //       showAlertDialog(
                                  //           context, value['message']);
                                  //     } else {
                                  //       _controller.changeFavoriteState(index);
                                  //     }
                                  //   });

                                  // });
                                  Fluttertoast.showToast(
                                      msg: 'this service is not available');
                                },
                                onLongPress: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.w),
                                          decoration: BoxDecoration(
                                            color: Color(0xff444444),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  IconButton(
                                                    icon: const ImageIcon(
                                                      AssetImage(
                                                          'assets/images/pin.png'),
                                                      size: 17.5,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                  const Text(
                                                    'Pin',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Poppins',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  IconButton(
                                                    icon: const ImageIcon(
                                                      AssetImage(
                                                          'assets/images/copyitem.png'),
                                                      size: 17.5,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                  const Text(
                                                    'Copy',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Poppins',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  IconButton(
                                                    icon: const ImageIcon(
                                                      AssetImage(
                                                          'assets/images/copylink.png'),
                                                      size: 17.5,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                  const Text(
                                                    'Copy Link',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Poppins',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  IconButton(
                                                    icon: const ImageIcon(
                                                      AssetImage(
                                                          'assets/images/report.png'),
                                                      size: 17.5,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                  const Text(
                                                    'Report',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Poppins',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: VideoPlayerItem(
                                  // ignore: invalid_use_of_protected_member
                                  videoUrl:
                                      _controller.postData.value[index].path!,
                                  autoPlay: true,
                                  looping: true,
                                  isMuted: 1,
                                ),
                              ),
                              Column(
                                children: [
                                  const SizedBox(height: 100),
                                  Expanded(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding:
                                                EdgeInsets.only(left: 16.w),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                ProfilePage(
                                                                  isSelfPage:
                                                                      false,
                                                                  userId: _controller
                                                                      .postData
                                                                      .value[
                                                                          index]
                                                                      .user!
                                                                      .id!,
                                                                )));
                                                  },
                                                  child: Text(
                                                    '@${_controller.postData.value[index].user!.name!}',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.sp,
                                                      fontFamily: 'poppins',
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10.h),
                                                Text(
                                                  // ignore: invalid_use_of_protected_member
                                                  _controller
                                                      .postData
                                                      .value[index]
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
                                                        fontWeight:
                                                            FontWeight.w700,
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
                                                                shape: BoxShape
                                                                    .circle,
                                                                image: DecorationImage(
                                                                    image: NetworkImage(_controller
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
                                                                            userId:
                                                                                _controller.postData.value[index].user!.id!,
                                                                          )));
                                                            },
                                                          ),
                                                          Positioned(
                                                            bottom: 0,
                                                            left: 18.w,
                                                            child: Container(
                                                              width: 20.w,
                                                              height: 20.h,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration: const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .blue),
                                                              child: Center(
                                                                child:
                                                                    LikeButton(
                                                                  onTap: (bool
                                                                      isFollowed) async {
                                                                    await checkLogin(
                                                                        context,
                                                                        () {
                                                                      Controller()
                                                                          .addFllow(
                                                                              user_id: _controller.postData.value[index].user!.id)
                                                                          .then((value) {
                                                                        if (value['status'] !=
                                                                            true) {
                                                                          showAlertDialog(
                                                                              context,
                                                                              value['message']);
                                                                        } else {
                                                                          _controller
                                                                              .changeIsFollowState(index);
                                                                        }
                                                                      });
                                                                    });

                                                                    return !isFollowed;
                                                                  },
                                                                  size: 15,
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
                                                                      _controller.postData.value[index].user!.isFollow! ==
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
                                                        onTap: (bool
                                                            isLiked) async {
                                                          await checkLogin(
                                                              context, () {
                                                            Controller()
                                                                .addLike(
                                                                    post_id: _controller
                                                                        .postData
                                                                        .value[
                                                                            index]
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
                                                            color: isLike &&
                                                                    _controller
                                                                        .postData
                                                                        .value[
                                                                            index]
                                                                        .isFavorite!
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
                                                        countBuilder:
                                                            (int? count,
                                                                bool isLiked,
                                                                String text) {
                                                          var color = isLiked
                                                              ? Colors.red
                                                              : Colors.grey;
                                                          Widget result;
                                                          // ignore: unrelated_type_equality_checks
                                                          if (count == 0) {
                                                            result = const Text(
                                                              "0",
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Colors
                                                                      .white),
                                                            );
                                                          } else {
                                                            result = Text(
                                                              text,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      10.sp,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Colors
                                                                      .white),
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
                                                        isScrollControlled:
                                                            true,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        context: context,
                                                        builder: (context) =>
                                                            CommentScreen(
                                                                _controller
                                                                    .postData
                                                                    .value[
                                                                        index]
                                                                    .id,
                                                                _controller
                                                                    .postData
                                                                    .value[
                                                                        index]
                                                                    .commentsCount),
                                                      );
                                                      setState(() {
                                                        _controller
                                                            .postData
                                                            .value[index]
                                                            .commentsCount;
                                                      });
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/messege.png',
                                                          width: 40.h,
                                                          height: 40.h,
                                                          color:
                                                              Colors.grey[400],
                                                        ),
                                                        Text(
                                                          _controller
                                                              .postData
                                                              .value[index]
                                                              .commentsCount
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              fontFamily:
                                                                  'Poppins',
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 20.h),
                                                  InkWell(
                                                    onTap: () async {
                                                      final urlPreview =
                                                          _controller
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
                                                          color:
                                                              Colors.grey[400],
                                                        ),
                                                        Text(
                                                          '0',
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color:
                                                                  Colors.white),
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
                        }),
                  ),
                ],
              );
            }),
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
