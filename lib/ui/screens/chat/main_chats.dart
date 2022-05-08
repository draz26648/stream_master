import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_master/api/stream_web_services.dart';
import 'package:stream_master/controllers/chat_controller.dart';
import 'package:stream_master/ui/screens/chat/chat_screen.dart';

import '../../../controllers/profile_controller.dart';
import '../../../models/chats_model.dart';
import '../../../models/profile.dart';
import '../main_widgets/app_loader.dart';

class MainChatScreen extends StatefulWidget {
  const MainChatScreen({Key? key}) : super(key: key);

  @override
  State<MainChatScreen> createState() => _MainChatScreenState();
}

class _MainChatScreenState extends State<MainChatScreen> {
  bool isLoading = false;
  final ProfileController _profileController = ProfileController.to;
  final ChatController _chatController = ChatController.to;
  getProfile() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Controller().getProfile(0).then((value) {
        setState(() {
          isLoading = false;
        });
        if (value != null) {
          setState(() {
            _profileController.data.value = UserData.fromJson(value['data']);
          });
          print("the data is ${value['data']}");
        } else {
          print("the data is null");
        }
      });
    } catch (error) {
      print(error);
      setState(() {
        isLoading = false;
      });
    }
  }

  bool chatLoaded = false;
  getAllChats() async {
    setState(() {
      chatLoaded = true;
    });
    try {
      await Controller().getChats().then((value) {
        setState(() {
          chatLoaded = false;
        });
        if (value != null) {
          setState(() {
            value.forEach((element) {
              _chatController.chats.value.add(GeneralChats.fromJson(element));
            });
          });
          print(_chatController.chats.value);
        } else {
          print("the data is null");
        }
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    getProfile();
    getAllChats();
    super.initState();
  }

  @override
  void dispose() {
    _chatController.chats.value.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: isLoading
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
          : SingleChildScrollView(
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
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              _profileController.data.value.avatar!),
                          radius: 25,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _profileController.data.value.name!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '@${_profileController.data.value.name!}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  chatLoaded
                      ? AppLoader(
                          all: true,
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height -
                              (75 + 20 + 20),
                          child: ListView.separated(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => ChatScreen(
                                                    chatId: _chatController
                                                        .chats.value[index].id!,
                                                    userId: _chatController
                                                        .chats
                                                        .value[index]
                                                        .participants![1]
                                                        .id!,
                                                  )));
                                    },
                                    child: buildChatItem(
                                      _chatController.chats.value[index]
                                          .participants![1].name,
                                      _chatController.chats.value[index]
                                          .participants![1].avatar,
                                      _chatController.chats.value[index].title,
                                    ),
                                  ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 5,
                                  ),
                              itemCount: _chatController.chats.value.length),
                        ),
                ],
              ),
            ),
    );
  }

  Widget buildChatItem(
    String? name,
    String? avatar,
    String? message,
  ) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            width: 20,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(avatar!),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name!,
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                message!,
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ]));
  }
}
