// ignore_for_file: file_names

import 'package:dotslash/Feed/feedPage.dart';
import 'package:dotslash/Leaderboard/leaderboard.dart';
import 'package:dotslash/colorScheme.dart';
import 'package:dotslash/ngoScreens/ngoProfile.dart';

import 'package:dotslash/ngoScreens/ngoHomeScreen.dart';
import 'package:flutter/material.dart';

class NgoBottomNavbar extends StatefulWidget {
  const NgoBottomNavbar({super.key});

  @override
  _NgoBottomNavbarState createState() => _NgoBottomNavbarState();
}

class _NgoBottomNavbarState extends State<NgoBottomNavbar> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    NgoHomeScreen(),
    LeaderBoard(),
    FeedPage(),
    NgoProfilePage()
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
        backgroundColor: AppStyle.TextColor1,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
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
        unselectedItemColor: AppStyle.BackgroundColor,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
