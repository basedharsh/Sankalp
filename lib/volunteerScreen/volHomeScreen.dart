import 'package:dotslash/ExtraScreens/category_list/category_list.dart';
import 'package:dotslash/ExtraScreens/drawer/drawer.dart';
import 'package:dotslash/ExtraScreens/explore_projects/explore_projects.dart';

import 'package:dotslash/Widgets/search_page.dart';
import 'package:dotslash/colorScheme.dart';
import 'package:dotslash/resources/exploreData/explore_data.dart';
import 'package:dotslash/volunteerScreen/VolWid/volDrawer.dart';
import 'package:dotslash/volunteerScreen/volunteerProjectScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class VolHomeScreen extends StatefulWidget {
  const VolHomeScreen({Key? key}) : super(key: key);

  @override
  State<VolHomeScreen> createState() => _VolHomeScreenState();
}

class _VolHomeScreenState extends State<VolHomeScreen> {
  List<Widget> exploreItems = [];
  ExploreData exploreData = ExploreData();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = true;

  void fetchData() async {
    exploreItems = await exploreData.fetchExploreData(context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    print("Explore Items: $exploreItems");
    return Scaffold(
      drawer: VolDrawer(),
      appBar: AppBar(
        backgroundColor: AppStyle.HighlightColor,
        toolbarHeight: 110,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(_auth.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return Container();
                }

                final userData = snapshot.data;

                return Text(
                  userData?['username'] ?? '',
                  style: TextStyle(
                    color: AppStyle.TextColor1,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                );
              },
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(_auth.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return Container();
                }
                final userData = snapshot.data;
                return Row(
                  children: [
                    Text(
                      '${userData?['karma'] ?? 0}', // Adjust the field name accordingly
                      style: TextStyle(
                        color: AppStyle.TextColor1,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(width: 2),
                    Image.asset(
                      'assets/images/karma_final.png', // Adjust the path accordingly
                      width: 35, // Adjust the width as needed
                      height: 35, // Adjust the height as needed
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              SizedBox(width: 10),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(_auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return Container();
                  }

                  final userData = snapshot.data;

                  return CircleAvatar(
                    backgroundImage: Image.asset(
                      "assets/logo/defaultprofilepic.png",
                    ).image,
                    radius: 40,
                  );
                },
              ),
              SizedBox(width: 10),
            ],
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15,
              ),
              child: Text(
                "Explore",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  letterSpacing: 1,
                ),
              ),
            ),
            isLoading
                ? Container(
                    height: 180,
                    child: Center(
                      child: Lottie.asset(
                        'assets/animation/loading.json',
                        width: 50,
                        height: 50,
                        repeat: true,
                      ),
                    ),
                  )
                : ExploreProjects(exploreItems: exploreItems),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 8,
              ),
              child: Text(
                "Categories",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  letterSpacing: 1,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Categories(),
            SizedBox(height: 20),
            Text(
              "Enrolled Projects",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 19,
                letterSpacing: 1,
              ),
            ),
            // Add a ListView of cards for recent projects

            Container(
              height: 200, // Adjust the height as needed
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(_auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!userSnapshot.hasData) {
                    return Center(
                      child: Text("User not found"),
                    );
                  }

                  final userData = userSnapshot.data;
                  final List<String> projectList =
                      List<String>.from(userData?['projectList'] ?? []);

                  // Conditional logic to handle an empty projectList
                  return projectList.isNotEmpty
                      ? StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('projects')
                              .where(FieldPath.documentId, whereIn: projectList)
                              .snapshots(),
                          builder: (context, projectSnapshot) {
                            if (projectSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (!projectSnapshot.hasData ||
                                (projectSnapshot.data as QuerySnapshot)
                                    .docs
                                    .isEmpty) {
                              return Center(
                                child: Text("No recent projects"),
                              );
                            }

                            final projects =
                                (projectSnapshot.data as QuerySnapshot).docs;

                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: projects.length,
                              itemBuilder: (context, index) {
                                var project = projects[index].data()
                                    as Map<String, dynamic>;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Action on tap
                                    },
                                    child: Container(
                                      width: 150, // Adjust the width as needed

                                      child: Card(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                              height:
                                                  70, // Adjust as needed, e.g., 50% of container height
                                              child: Image.network(
                                                project['projectImage'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                project['projectName'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Project Goal: ${project['projectGoal']}",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : Center(
                          child: Text("You have no projects in your list."));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
