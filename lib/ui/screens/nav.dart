import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:stream_master/ui/screens/add_video.dart';
import 'package:stream_master/ui/screens/discoverPage.dart';
import 'package:stream_master/ui/screens/home.dart';
import 'package:stream_master/ui/screens/profile_screen.dart';
import 'package:stream_master/ui/screens/shoot_screen.dart';
import 'package:stream_master/utils.dart';

import 'chat/main_chats.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int currentIndex = 0;
  bool hasInternet = true;

  onTap(index) async {
    if (mounted) {
      setState(() {
        currentIndex = index;
      });
    }
    if (currentIndex != 0 || currentIndex != 1) {
      await checkLogin(
        context,(){

        }
      );
    }
  }

  checkInternet() async {
    bool internet = await InternetConnectionChecker().hasConnection;
    setState(() {
      hasInternet = internet;
    });
  }

  List pages = [
    const HomePage(
      key: PageStorageKey('homepage'),
    ),
    const DiscoverPage(),
    // CreatVideo(),
    ShootingScreen(),
    MainChatScreen(),
    const ProfilePage(
      isSelfPage: true,
      userId: 0,
    ),
  ];
  DateTime timebackPress = DateTime.now();

  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return hasInternet
        ? WillPopScope(
            onWillPop: () async {
              final differance = DateTime.now().difference(timebackPress);
              final isExitWarning = differance >= const Duration(seconds: 2);

              timebackPress = DateTime.now();
              if (isExitWarning) {
                Fluttertoast.showToast(msg: 'Press again to exit');
                return false;
              } else {
                Fluttertoast.cancel();
                return true;
              }
            },
            child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor:
                    currentIndex == 0 ? Colors.white : Colors.black,
                unselectedItemColor: Colors.grey,
                backgroundColor:
                    currentIndex == 0 ? Colors.black : Colors.white,
                currentIndex: currentIndex,
                onTap: onTap,
                items: [
                  const BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage('assets/images/home-2.png'),
                      size: 24,
                    ),
                    label: 'Home',
                  ),
                  const BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage('assets/images/search.png'),
                      size: 24,
                    ),
                    label: 'Discover',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset('assets/images/live.png'),
                    label: '',
                  ),
                  const BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage('assets/images/chat.png'),
                      size: 24,
                    ),
                    label: 'Chat',
                  ),
                  const BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage('assets/images/profile.png'),
                      size: 24,
                    ),
                    label: 'Me',
                  ),
                ],
              ),
              body: pages[currentIndex],
            ),
          )
        : buildNoInternetWidget();
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                'Can\'t connect .. check internet',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ),
            Image.asset('assets/images/no_internet.png')
          ],
        ),
      ),
    );
  }
}
