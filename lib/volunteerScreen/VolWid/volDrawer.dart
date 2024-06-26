import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotslash/Authorization/Login/loginScreen.dart';
import 'package:dotslash/colorScheme.dart';
import 'package:dotslash/volunteerScreen/VolWid/mapScreen.dart';
import 'package:dotslash/volunteerScreen/helpUpload.dart';
import 'package:dotslash/volunteerScreen/volProjectTimeLine.dart';
import 'package:dotslash/volunteerScreen/volunteerHelpPost.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VolDrawer extends StatefulWidget {
  @override
  State<VolDrawer> createState() => _VolDrawerState();
}

class _VolDrawerState extends State<VolDrawer> {
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
        ? const CircularProgressIndicator()
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
                      const Icon(Icons.account_circle, size: 80.0),
                      Text(profileData!['username'],
                          style: const TextStyle(fontSize: 25.0)),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: AppStyle.HighlightColor,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.verified_user),
                  title: const Text('Badges and Exp'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VolTimeLine(),
                        ));
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.visibility),
                //   title: Text('View Applications'),
                //   onTap: () {},
                // ),
                // ListTile(
                //   leading: Icon(Icons.group),
                //   title: Text('Volunteer Management'),
                //   onTap: () {
                //     // Handle the tap
                //   },
                // ),
                // // ListTile(
                //   leading: Icon(Icons.account_balance_wallet),
                //   title: Text('Ethereum Wallet'),
                //   onTap: () {
                //     // downloadAndSavePdfFromUrl(
                //     //         'https://firebasestorage.googleapis.com/v0/b/dotslash-fbea8.appspot.com/o/uploads%2FKggnmkWKAyQi4f3IL33Qnbimgcq2.pdf?alt=media&token=bf247bba-2872-46c4-a0ad-cf3476658897')
                //     //     .then((localPath) {
                //     //   Navigator.push(
                //     //     context,
                //     //     MaterialPageRoute(
                //     //       builder: (context) => PdfViewerPage(path: localPath),
                //     //     ),
                //     //   );
                //     // });
                //   },
                // ),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text('Post'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HelpUploadScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.map),
                  title: const Text('Map Page'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MapScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.map),
                  title: const Text('Work/Help Post'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const VolunteerHelpPosts(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
  }
}
