import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


import '../../api/stream_web_services.dart';
import '../../utils.dart';
import '../widgets/constants.dart';

class CommentScreen extends StatefulWidget {
  var postId;
  var commentCount;

  CommentScreen(this.postId,this.commentCount);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late var data = [];

  bool isloading = false;

  getComment() async {
    setState(() {
      isloading = true;
    });
    try {
      Controller().getComment(widget.postId).then((value) => {
        setState(() {
          isloading = false;
        }),
        if (value != null)
          {
            setState(() {
              data = value['data'];

              // value.forEach((v) {
              //   _tags.add(Cat.fromJson(v));
              // });
            }),
            print("the data is ${value['data']}"),
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
    getComment();
    // addComment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    TextEditingController _commentController = TextEditingController();

    return isloading
        ? const Center(
      child: CircularProgressIndicator(),
    )
        : Padding(
         padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 50.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  // border: Border.all(color: color1),
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
                      'Comment   ${widget.commentCount}',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontFamily: 'poppins',
                        fontSize: 17.sp,
                      ),
                    ),
                    InkWell(
                      onTap:(){ Navigator.pop(context);},
                      child: Image.asset('assets/images/close.png'),
                    ),
                  ],
                ),
              ),
              Container(
                color: Color(0xff232324),
                height: 380.h,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 19.r,
                        backgroundImage: NetworkImage(data[index]['user']['avatar']),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[index]['user']['name'],
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
                            data[index]['description'],
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
                            DateFormat.MMMMEEEEd().format(DateTime.parse(data[index]['created_at'])).toString(),
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
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                height: 86.h,
                color: Color(0xff434343),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundImage: AssetImage('assets/images/commentpic.png'),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      width: 264.w,
                      child: TextFormField(
                        controller: _commentController,
                        style: TextStyle(),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Add Comment',
                          // hintText: SharedPrefrencesHelper.sharedPrefrencesHelper.getLogin() != null? 'Comment as ${}' : 'Add Comment',
                          hintStyle: TextStyle(color: color1, fontFamily: 'poppins'),
                          labelStyle: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
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
                    // SizedBox(width: 10.w),
                    IconButton(
                      onPressed: () {
                        if(_commentController.text.isNotEmpty){
                          checkLogin(context, () {
                            // showLoaderDialog(context);
                            Controller().addComment(post_id: widget.postId,description: _commentController.text).then((value) {
                              if (value.containsKey("message")) {
                                showAlertDialog(context,value['message']);
                                // var snackBar = SnackBar(content: Text(value['message']),);
                                // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }else {
                                _commentController.text = "";
                              }
                              // Navigator.of(context, rootNavigator: true).pop();
                            });
                          });
                        }else {
                          var snackBar = SnackBar(content: Text('fill the comment filed'),);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }

                      },
                      icon: Image.asset(
                        'assets/images/sendss.png',
                        width: 50.w,
                        height: 50.h,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
  }
}
