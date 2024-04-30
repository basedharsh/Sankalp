// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotslash/ngoScreens/ngoEditProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NgoProfilePage extends StatefulWidget {
  static List<Widget> userPostsImagesList = [];
  const NgoProfilePage({super.key});

  @override
  State<NgoProfilePage> createState() => _NgoProfilePageState();
}

class _NgoProfilePageState extends State<NgoProfilePage> {
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
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : SafeArea(
            child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [Icon(Icons.menu_sharp, size: 35)],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEO3eNKM_EnPZKoH6CtQnNUIfEOzqjyQbPTA&usqp=CAU"),
                              radius: 47,
                            ),
                          ),
                          Column(
                            children: [
                              Text(profileData!["postList"].length.toString()),
                              Text("Posts",
                                  style: Theme.of(context).textTheme.bodyMedium)
                            ],
                          ),
                          Column(
                            children: [
                              Text(profileData!["projectList"]
                                  .length
                                  .toString()),
                              Text("Project",
                                  style: Theme.of(context).textTheme.bodyMedium)
                            ],
                          ),
                          Column(
                            children: [
                              Text("10000"),
                              Text("Karmas",
                                  style: Theme.of(context).textTheme.bodyMedium)
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(profileData!['username'],
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text("Ngo Bio",
                                style: Theme.of(context).textTheme.bodySmall),
                            Text("Ngo Website Link",
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      MaterialButton(
                        color: Colors.black,
                        minWidth: double.infinity,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NgoEditProfile()));
                        },
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: CustomScrollView(
                    primary: false,
                    slivers: <Widget>[
                      SliverPadding(
                        padding: const EdgeInsets.all(0),
                        sliver: SliverGrid.count(
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                            crossAxisCount: 3,
                            children: NgoProfilePage.userPostsImagesList),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ));
  }
}
