import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:stream_master/helper/shared_prefrences_helper.dart';
import 'package:stream_master/models/comments_model.dart';

import '../../api/stream_web_services.dart';
import '../../models/login_model.dart';
import '../../utils.dart';
import '../widgets/constants.dart';
import 'main_widgets/app_loader.dart';

class CommentScreen extends StatefulWidget {
  var postId;
  var commentCount;

  CommentScreen(this.postId, this.commentCount);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late List<Data2> fetchedComments = [];
  late List<Data> fetchedPages = [];

  int _pages = 1;
  int _limit = 10;
  int totalComments = 0;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;

  bool isloading = false;
  bool iscomment = false;
  
  String? profilePic;
  void getComment() async {
    setState(() {
      isloading = true;
      _isFirstLoadRunning = true;
    });
    try {
      await Controller()
          .getProfile(0)
          .then((value) => profilePic = value['data']['avatar']);

      await Controller().getComment(widget.postId, _pages).then((value) => {
            setState(() {
              isloading = false;
            }),
            if (value != null)
              {
                setState(() {
                  value.forEach((element) {
                    fetchedComments.add(Data2.fromJson(element));
                  });
                }),
              }
            else
              {}
          });
      await Controller().getCommentPages(widget.postId).then((value) => {
            setState(() {
              value.forEach((e) {
                fetchedPages.add(Data.fromJson(e));
              });
              _limit = fetchedPages[0].lastPage!;
              totalComments = fetchedPages[0].total!;
            }),
          });
    } catch (e) {
      print(e);
      setState(() {
        isloading = false;
        _isFirstLoadRunning = false;
      });
    }
  }

  void postComment(String? commentText) async {
    setState(() {
      iscomment = true;
    });
    try {
      await Controller()
          .addComment(post_id: widget.postId, description: commentText!)
          .then((value) {
        setState(() {
          iscomment = false;
        });
        if (value != null) {
          setState(() {
            fetchedComments.add(Data2.fromJson(value));
          });
        }
      });
    } catch (e) {
      {
        print(e);
        setState(() {
          iscomment = false;
        });
      }
    }
  }

  void loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _scrollController.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _pages += 1; // Increase _page by 1
      try {
        await Controller().getComment(widget.postId, _pages).then((value) => {
              setState(() {
                isloading = false;
              }),
              if (value != null)
                {
                  setState(() {
                    value.forEach((element) {
                      fetchedComments.add(Data2.fromJson(element));
                    });
                  }),
                }
              else
                {}
            });
      } catch (err) {
        print('Something went wrong!');
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  late ScrollController _scrollController;

  @override
  void initState() {
    getComment();
    // addComment();
    super.initState();
    _scrollController = ScrollController()..addListener(loadMore);
  }

  @override
  void dispose() {
    _scrollController.removeListener(loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _commentController = TextEditingController();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 50.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Color(0xff232324),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    topRight: Radius.circular(15.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Comments ${totalComments}',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'poppins',
                        fontSize: 17.sp,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(
                          context,
                        );
                      },
                      child: Image.asset('assets/images/close.png'),
                    ),
                  ],
                ),
              ),
              Container(
                color: Color(0xff232324),
                height: 380.h,
                child: isloading && _isFirstLoadRunning
                    ? Center(
                        child: AppLoader(),
                      )
                    : Stack(
                        children: [
                          ListView.builder(
                            controller: _scrollController,
                            itemCount: fetchedComments.length,
                            itemBuilder: ((context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  radius: 19.r,
                                  backgroundImage: NetworkImage(
                                      fetchedComments[index].user!.avatar!),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      fetchedComments[index].user!.name!,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'poppins',
                                        fontSize: 17.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      fetchedComments[index].description!,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'poppins',
                                        fontSize: 17.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      DateFormat.MMMMEEEEd()
                                          .format(DateTime.parse(
                                              fetchedComments[index]
                                                  .createdAt!
                                                  .toString()))
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 12.5.sp,
                                        color: Color(0xffDBDBDB),
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25.w,
                                    ),
                                    Text(
                                      'Replay',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Color(0xffDBDBDB),
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: InkWell(
                                  onTap: () => {},
                                  child: const Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              );
                            }),
                          ),
                          // if (_isLoadMoreRunning == true)
                          //   Center(
                          //     child: AppLoader(),
                          //   ),
                        ],
                      ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                height: 86.h,
                color: Color(0xff434343),
                child: SharedPrefrencesHelper.sharedPrefrencesHelper.getToken !=
                        null
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundImage: NetworkImage(profilePic != null
                                ? profilePic!
                                : 'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png'),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Container(
                              width: 264.w,
                              child: TextFormField(
                                controller: _commentController,
                                style: TextStyle(),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 20.w),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Add Comment',
                                  hintStyle: TextStyle(
                                      color: color1, fontFamily: 'poppins'),
                                  labelStyle: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.r),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.r),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          isloading || iscomment
                              ? Container(
                                width: 50,
                                height: 50,
                                child: AppLoader(
                                  iscomment: true,
                                ),
                              )
                              : IconButton(
                                  onPressed: () {
                                    if (_commentController.text.isNotEmpty) {
                                      checkLogin(context, () {
                                        postComment(_commentController.text);
                                        _commentController.clear();
                                      });
                                      getComment();
                                    } else if (_commentController
                                        .text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: 'Please enter comment');
                                    }
                                    
                                  },
                                  icon: Image.asset(
                                    'assets/images/sent.png',
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                     
                        ],
                      )
                    : const Center(
                        child: Text('Login to comment'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
