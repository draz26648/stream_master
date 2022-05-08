import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_master/controllers/message_controller.dart';
import 'package:stream_master/models/message_model.dart';

import 'package:stream_master/ui/screens/main_widgets/custom_text_field.dart';

import '../../../api/stream_web_services.dart';
import '../../../controllers/profile_controller.dart';
import '../../../models/profile.dart';

class ChatScreen extends StatefulWidget {
  final int userId;
  final int chatId;
  const ChatScreen({Key? key, required this.userId, required this.chatId})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController sendMessageController = TextEditingController();
  bool isLoading = false;
  final ProfileController _profileController = ProfileController.to;
  final MessageController _messageController = MessageController.to;

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

  bool messageloading = false;
  getMessages() async {
    setState(() {
      messageloading = true;
    });
    try {
      await Controller()
          .getChatMessages(
        chat_id: widget.chatId,
        user_id: widget.userId,
      )
          .then((value) {
        setState(() {
          messageloading = false;
        });
        if (value != null) {
          setState(() {
            value.forEach((element) {
              _messageController.chatData.value.add(ChatData.fromJson(element));
            });
          });
          print("the data is ${value}");
          _messageController.chatData
              .sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        } else {
          print("the data is null");
        }
      });
    } catch (error) {
      print(error);
      setState(() {
        messageloading = false;
      });
    }
  }

  final StreamController<int> _chatcount = StreamController<int>();
  Stream<int> get chatCount => _chatcount.stream;

  Stream<List<ChatData>> get messageListStream async* {
    yield _messageController.chatData.value;
  }

  sendMessage(
    String message,
  ) async {
    setState(() {
      messageloading = true;
    });
    try {
      await Controller().sendMessage(
        chat_id: widget.chatId,
        message: message,
      );
    } catch (error) {
      print(error);
      setState(() {
        messageloading = false;
      });
    }
  }

  @override
  void initState() {
    getProfile();
    getMessages();

    super.initState();
  }

  @override
  void dispose() {
    _messageController.chatData.value.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          buildTopBar(context),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (widget.userId ==
                        int.parse(_messageController.chatData[index].userId!)) {
                      return buildMessage(
                        _messageController.chatData[index].message,
                      );
                    } else if (widget.chatId ==
                        int.parse(
                            _messageController.chatData.value[index].chatId!)) {
                      return buildMyMessage(
                        _messageController.chatData[index].message,
                      );
                    }
                    return Container();
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 15,
                  ),
                  itemCount: _messageController.chatData.length,
                ),
              ),
            ),
          ),
          buildSendBox(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Container buildTopBar(BuildContext context) {
    return Container(
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
            backgroundImage:
                NetworkImage(_profileController.data.value.avatar!),
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
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/setting.png',
            ),
          )
        ],
      ),
    );
  }

  Column buildSendBox() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 5,
              ),
              CircleAvatar(
                backgroundImage:
                    NetworkImage(_profileController.data.value.avatar!),
                radius: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: CustomTextField(
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a message';
                    }
                  },
                  controller: sendMessageController,
                  label: 'Message',
                ),
              ),
              IconButton(
                  onPressed: () {
                    if (sendMessageController.text.isNotEmpty) {
                      sendMessage(sendMessageController.text);

                      sendMessageController.clear();
                      // messageListStream
                      //     .listen((event) => _chatcount.add(event.length));
                    }
                  },
                  icon: ImageIcon(AssetImage('assets/images/sendss.png'))),
            ],
          ),
        ),
      ],
    );
  }

  Align buildMyMessage(
    String? message,
  ) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Color(0xff6979F8),
          borderRadius: const BorderRadiusDirectional.only(
            bottomStart: Radius.circular(20),
            topEnd: Radius.circular(20),
            topStart: Radius.circular(20),
          ),
        ),
        child: Text(
          message!,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Align buildMessage(
    String? message,
  ) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(20),
            topEnd: Radius.circular(20),
            topStart: Radius.circular(20),
          ),
        ),
        child: Text(
          message!,
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
