// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotslash/Authorization/Login/loginScreen.dart';
import 'package:dotslash/colorScheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NgoDrawer extends StatefulWidget {
  const NgoDrawer({super.key});

  @override
  State<NgoDrawer> createState() => _NgoDrawerState();
}

class _NgoDrawerState extends State<NgoDrawer> {
  @override
  void initState() {
    setState(() {
      loading = true;
    });
    loadUserData();
    super.initState();
    // print(profileData);
    print("profileDataaaaaaaaaaaaaaaaaaaaaa");
  }

  bool loading = false;
  Map<String, dynamic>? profileData;
  Future<void> loadUserData() async {
    final db = FirebaseFirestore.instance;
    await db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      setState(() {
        profileData = value.data();
        loading = false;
        print(profileData);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? CircularProgressIndicator()
        : Drawer(
            backgroundColor: AppStyle.BackgroundColor,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.account_circle,
                        size: 80.0,
                        color: AppStyle.TextColor1,
                      ),
                      Text(profileData!['username'],
                          style: TextStyle(
                              fontSize: 25.0, color: AppStyle.TextColor1)),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: AppStyle.HighlightColor,
                  ),
                ),
                // ListTile(
                //   leading: Icon(Icons.verified_user),
                //   title: Text('Badges and Exp'),
                //   onTap: () {
                //     // Handle the tap
                //   },
                // ),
                ListTile(
                  leading: Icon(Icons.visibility),
                  title: Text('View Applications'),
                  onTap: () {
                    // Handle the tap
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.group),
                //   title: Text('Volunteer Management'),
                //   onTap: () {
                //     // Handle the tap
                //   },
                // ),
                // ListTile(
                //   leading: Icon(Icons.account_balance_wallet),
                //   title: Text('Ethereum Wallet'),
                //   onTap: () {
                //     // Handle the tap
                //   },
                // ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
  }
}
