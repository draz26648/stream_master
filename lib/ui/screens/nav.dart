

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:stream_master/ui/screens/add_video.dart';
import 'package:stream_master/ui/screens/discoverPage.dart';
import 'package:stream_master/ui/screens/home.dart';
import 'package:stream_master/ui/screens/profile_screen.dart';





class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int currentIndex = 0;

  onTap(index) {
    setState(() {
      currentIndex = index;
    });
  }

  List pages =  [
    HomePage(
      key: PageStorageKey('homepage'),
    ),
    DiscoverPage(),
    CreatVideo(),
    Scaffold(),
    ProfilePage(isSelfPage: true,),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled,size: 30,),
            // icon: Image.asset('assets/home.png'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,size: 30,),
            // icon: Image.asset('assets/search.png'),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/live.png'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined,size: 25,),
            // icon: Image.asset('assets/chat.png'),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline,size: 30,),
            // icon: Image.asset('assets/profile.png'),
            label: 'Me',
          ),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
