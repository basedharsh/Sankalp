// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotslash/volunteerScreen/volEditProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class VolProfilePage extends StatefulWidget {
  const VolProfilePage({Key? key}) : super(key: key);

  @override
  State<VolProfilePage> createState() => _VolProfilePageState();
}

class _VolProfilePageState extends State<VolProfilePage> {
  ScreenshotController screenshotController = ScreenshotController();
  bool loading = false;
  Map<String, dynamic>? profileData;
  List<Widget> postsList = [];
  List<Widget> recodData =
      []; // Ensure this is a list of Widgets since you're adding Rows to it.

  @override
  void initState() {
    super.initState();
    // Immediately start loading user data.
    loadUserData();
  }

  Future<void> loadUserData() async {
    // Indicate loading is true at the start of data fetching.
    setState(() {
      loading = true;
    });

    final db = FirebaseFirestore.instance;
    try {
      final userDoc = await db
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (userDoc.data() != null) {
        var userData = userDoc.data()!;
        setState(() {
          profileData = userData;
          profileData!['profileImageUrl'] = userData['profile_image'];
        });

        // Load recommendations.
        var recommendations = userData["recommendation"] as List<dynamic>;
        for (var recommendationId in recommendations) {
          var recUserDoc =
              await db.collection("users").doc(recommendationId).get();
          if (recUserDoc.data() != null) {
            var recUserData = recUserDoc.data()!;
            setState(() {
              recodData.add(
                Row(
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.network(
                        recUserData["profilePicture"],
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(recUserData["username"]),
                  ],
                ),
              );
            });
          }
        }

        // Load posts.
        var postList = userData["postList"] as List<dynamic>;
        for (var postId in postList) {
          var postDoc = await db.collection("posts").doc(postId).get();
          if (postDoc.data() != null) {
            var postData = postDoc.data()!;
            setState(() {
              postsList.add(
                  GestureDetector(child: Image.network(postData["postImage"])));
            });
          }
        }
      }
    } catch (e) {
      // Handle any errors, perhaps set an error message in the state if you wish to display it.
      if (kDebugMode) {
        print("Error loading user data: $e");
      }
    } finally {
      // Always set loading to false once data fetching is done or fails.
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : SafeArea(
            // Your existing SafeArea code here.

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
                        // child: Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [Icon(Icons.menu_sharp, size: 35)],
                        // ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              radius: 45,
                              backgroundImage: profileData != null &&
                                      profileData!['profileImageUrl'] != null &&
                                      profileData!['profileImageUrl'].isNotEmpty
                                  ? NetworkImage(
                                      profileData!['profileImageUrl'])
                                  : AssetImage(
                                          'assets/logo/defaultprofilepic.png')
                                      as ImageProvider,
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
                              Row(
                                children: [
                                  Text(profileData!["karma"].toString()),
                                  SizedBox(width: 2),
                                  Image.asset(
                                    'assets/images/karma_final.png', // Adjust the path accordingly
                                    width: 35, // Adjust the width as needed
                                    height: 35, // Adjust the height as needed
                                  ),
                                ],
                              ),
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
                            Text(
                              profileData!['bio'] ?? 'No bio available',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),

                            // Text("Ngo Website Link",
                            //     style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text("Badges earned",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                      SizedBox(height: 20),
                      //This is badges earned part
                      _displayBadges(),
                      Container(
                        width: double
                            .infinity, // Make sure it stretches across the screen
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2), // Slight shadow for depth
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "You are being recommended by",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors
                                      .deepPurple, // Stylish color for the header
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              child: ListView.builder(
                                scrollDirection: Axis
                                    .horizontal, // Makes it horizontally scrollable
                                itemCount: recodData.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple[
                                          100], // Light purple background for each item
                                      borderRadius: BorderRadius.circular(
                                          20), // Rounded corners for tags
                                    ),
                                    alignment: Alignment.center,
                                    child: recodData[
                                        index], // Assuming recodData[index] is a String or properly formatted Widget
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      MaterialButton(
                        color: Colors.black,
                        minWidth: double.infinity,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VolEditProfile()));
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
                            children: postsList),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ));
  }

// To display badges as per Karma of user
  Widget _displayBadges() {
    int karma = profileData!["karma"];
    if (karma < 50) {
      return GestureDetector(
        onTap: () => _showBadgeDetails(
            "Earn More",
            "Engage more and earn more karmas to unlock badges. Keep participating!",
            'assets/images/karma_final.png'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Earn more ",
                style: TextStyle(color: Colors.black, fontSize: 25)),
            Image.asset(
              'assets/images/karma_final.png',
              width: 35,
              height: 35,
            ),
          ],
        ),
      );
    } else if (karma >= 50 && karma < 100) {
      return GestureDetector(
        onTap: () => _showBadgeDetails(
            "50 Karmas Badge",
            "Congratulations! You earned the 50 karmas badge.",
            'https://github.com/basedharsh/Hackey-Hackey-Sankalp/assets/90195370/4ed41bfe-17e8-411a-91e1-b18b9decc18c'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: Image.network(
                      'https://github.githubassets.com/assets/pull-shark-default-498c279a747d.png')
                  .image,
            ),
          ],
        ),
      );
    } else if (karma >= 100) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => _showBadgeDetails(
                "50 Karmas Badge",
                "Congratulations! You earned the 50 karmas badge.",
                'https://github.githubassets.com/assets/pull-shark-default-498c279a747d.png'),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: Image.network(
                      'https://github.githubassets.com/assets/pull-shark-default-498c279a747d.png')
                  .image,
            ),
          ),
          GestureDetector(
            onTap: () => _showBadgeDetails(
                "100 Karmas Badge",
                "Amazing! You've reached the 100 karmas badge.",
                'https://github.githubassets.com/assets/quickdraw-default-39c6aec8ff89.png'),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: Image.network(
                      'https://github.githubassets.com/assets/quickdraw-default-39c6aec8ff89.png')
                  .image,
            ),
          ),
        ],
      );
    } else {
      return Container(); // In case none of the conditions are met
    }
  }

  void _showBadgeDetails(String title, String content, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Screenshot(
            controller: screenshotController,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                // Use SingleChildScrollView to handle content that might overflow
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(imageUrl, width: 100, height: 100),
                    ),
                    SizedBox(height: 20),
                    Text(title,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54)),
                    SizedBox(height: 10),
                    Text(content,
                        style:
                            TextStyle(fontSize: 18, color: Colors.grey[600])),
                    Divider(height: 30, thickness: 2), // Aesthetic divider
                    Text("User Details",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("Username: ${profileData!['username']}",
                        style: TextStyle(fontSize: 16)),
                    Text("Posts: ${profileData!['postList'].length}",
                        style: TextStyle(fontSize: 16)),
                    Text("Projects: ${profileData!['projectList'].length}",
                        style: TextStyle(fontSize: 16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Karmas: ${profileData!['karma']}",
                            style: TextStyle(fontSize: 16)),
                        SizedBox(width: 10),
                        Image.asset('assets/images/karma_final.png',
                            width: 20, height: 20),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close', style: TextStyle(fontSize: 18)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () async {
                            final Uint8List? image =
                                await screenshotController.capture();
                            if (image != null) {
                              String fileName =
                                  'badges/${DateTime.now().millisecondsSinceEpoch}.png';
                              final storageRef = FirebaseStorage.instance
                                  .ref()
                                  .child(fileName);
                              UploadTask uploadTask = storageRef.putData(image);
                              await uploadTask;
                              String fileURL =
                                  await storageRef.getDownloadURL();
                              Share.share('Check out my badge! $fileURL');
                            }
                          },
                          child: Text('Share', style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
