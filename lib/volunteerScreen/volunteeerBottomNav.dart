import 'package:dotslash/Feed/feedPage.dart';
import 'package:dotslash/Leaderboard/leaderboard.dart';
import 'package:dotslash/colorScheme.dart';
import 'package:dotslash/ngoScreens/ngoChatScreen.dart';
import 'package:dotslash/ngoScreens/ngoProfile.dart';

import 'package:dotslash/ngoScreens/ngoHomeScreen.dart';
import 'package:dotslash/volunteerScreen/volChatPage.dart';
import 'package:dotslash/volunteerScreen/volHomeScreen.dart';
import 'package:dotslash/volunteerScreen/volProfilePage.dart';
import 'package:flutter/material.dart';

class VolunteerBottomNav extends StatefulWidget {
  @override
  _VolunteerBottomNavState createState() => _VolunteerBottomNavState();
}

class _VolunteerBottomNavState extends State<VolunteerBottomNav> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    VolHomeScreen(),
    // volChatPage(),
    LeaderBoard(),
    FeedPage(),
    VolProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_add),
            label: 'Leader-Board',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dynamic_feed),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppStyle.HighlightColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
