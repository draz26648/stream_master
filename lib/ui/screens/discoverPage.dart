import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_master/api/stream_web_services.dart';

import 'main_widgets/custom_text_field.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> data = [];
  bool isloading = false;

  getResult() async {
    setState(() {
      isloading = true;
    });
    try {
      Controller().getSearchResult(_searchController.text).then((value) {
        if (value != null) {
          setState(() {
            data = value;
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
              Column(
                children: [
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: Text(data[index]['title'])),
                      );
                    },
                    itemCount: data == null ? 0 : data.length,
                    shrinkWrap: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
