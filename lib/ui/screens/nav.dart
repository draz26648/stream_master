import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:stream_master/ui/screens/add_video.dart';
import 'package:stream_master/ui/screens/discoverPage.dart';
import 'package:stream_master/ui/screens/home.dart';
import 'package:stream_master/ui/screens/profile_screen.dart';
import 'package:stream_master/ui/screens/shoot_screen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int currentIndex = 0;

  onTap(index) {
    if (mounted) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  List pages = [
    const HomePage(
      key: PageStorageKey('homepage'),
    ),
    const DiscoverPage(),
    CreatVideo(),
    // CameraPage(),
    const Scaffold(),
    const ProfilePage(
      isSelfPage: true,
      userId: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
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
    );
  }
}
