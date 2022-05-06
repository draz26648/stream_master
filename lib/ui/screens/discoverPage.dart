import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:path/path.dart';
import 'package:stream_master/api/stream_web_services.dart';
import 'package:stream_master/ui/screens/profile_screen.dart';
import 'package:video_thumbnail_imageview/video_thumbnail_imageview.dart';

import '../../models/searchModel.dart';
import '../widgets/video_player_item.dart';
import 'main_widgets/custom_text_field.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final TextEditingController _searchController = TextEditingController();
  var data;
  List<dynamic> fetchedUsers = [];
  List<dynamic> fetchedPosts = [];
  bool isloading = false;

  getResult() async {
    setState(() {
      isloading = true;
    });
    try {
      Controller().getSearchResult(_searchController.text).then((value) {
        if (value != null) {
          setState(() {
            fetchedUsers = value[0];
            fetchedPosts = value[1];
            // value.forEach((element) {
            //   if (element[0] != null) {
            //     fetchedUsers.add(User.fromJson(element[0]));
            //   } else if (element[1] != null) {
            //     fetchedPosts.add(Post.fromJson(element[1]));
            //   } else{
            //     print("error");
            //   }
            // });
            isloading = false;
          });
        } else {
          print('there is no data');
        }
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  void initState() {
    getResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 20.h,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 75,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.r),
                    bottomRight: Radius.circular(15.r),
                  ),
                ),
                child: Container(
                  width: 343.w,
                  height: 48.h,
                  padding: EdgeInsets.all(16.w),
                  child: TextFormField(
                    controller: _searchController,
                    onFieldSubmitted: (_) {
                      getResult();
                    },
                    decoration: InputDecoration(
                      focusColor: Colors.black,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(left: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: ScreenUtil().setSp(16),
                      ),
                      prefixIcon: const ImageIcon(
                        AssetImage('assets/images/search.png'),
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '#Users',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 100,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 5,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProfilePage(
                                        isSelfPage: false,
                                        userId: fetchedUsers[index]['id'])));
                          },
                          child: buildUserItem(
                            fetchedUsers[index]['avatar'],
                            fetchedUsers[index]['name'],
                          ),
                        ),
                        itemCount:
                            fetchedUsers == null ? 0 : fetchedUsers.length,
                        shrinkWrap: true,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      '#Posts',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 120,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 7,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            buildPostItem(fetchedPosts[index]['path'], context),
                        itemCount:
                            fetchedPosts == null ? 0 : fetchedPosts.length,
                        shrinkWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserItem(
    String? imageUrl,
    String? userName,
  ) =>
      SizedBox(
        width: 65.0,
        child: Column(
          children: [
            Stack(alignment: AlignmentDirectional.bottomEnd, children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(imageUrl!),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: 3.0,
                  end: 3.0,
                ),
              ),
            ]),
            const SizedBox(
              height: 5,
            ),
            Text(
              userName!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      );

  Widget buildPostItem(String? videoUrl, BuildContext ctx) => Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Stack(children: [
          Container(
            height: 200,
            width: 77,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
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
                  }, assetPlaceHolder: 'asset/images/',),
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
