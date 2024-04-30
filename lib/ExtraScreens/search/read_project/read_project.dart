import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:lottie/lottie.dart';

import '../../drawer/drawer.dart';

class ReadProject extends StatefulWidget {
  final String imageUrl;
  final String title;
  final int reviewCount;
  final String description;
  final String needDescription;
  final Map<dynamic, dynamic> applied;
  final String projectID;
  final String status;

  ReadProject({
    required this.imageUrl,
    required this.title,
    required this.reviewCount,
    required this.description,
    required this.needDescription,
    required this.applied,
    required this.projectID,
    required this.status,
  });

  @override
  State<ReadProject> createState() => _ReadProjectState();
}

class _ReadProjectState extends State<ReadProject> {
  void openCategoryTabsDrawer() {
    Scaffold.of(context).openDrawer();
  }

  bool isLiked = false;
  bool showLottie = false;
  bool isApplied = false; // Add a variable to track the application state
  String majdoorID = FirebaseAuth.instance.currentUser!.uid;

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  void applyVolunteer() {
    setState(() {
      isApplied = true; //Update the application state
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.applied);
    return Scaffold(
      drawer: DrawerScreen(
        openCategoryTabsDrawer: openCategoryTabsDrawer,
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 8,
        toolbarHeight: 60,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_open_rounded,
              size: 32,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    // Network Image with infinite width and height of 200
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.2), // Shadow color
                            spreadRadius: 2, // Spread radius
                            blurRadius: 4, // Blur radius
                            offset: const Offset(
                              0,
                              2,
                            ), // Offset in the positive direction vertically
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        child: Image.network(
                          widget.imageUrl,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Positioned Share Button
                    Positioned(
                      top: 10,
                      right: 15,
                      child: InkWell(
                        onTap: () {
                          toggleLike();
                        },
                        child: Image.asset(
                          'assets/icons/heart.png', // Path to your custom heart icon in assets
                          width: 22,
                          height: 22,
                          color: isLiked ? Colors.red : Colors.white,
                        ),
                      ),
                    ),
                    // Positioned Heart Button
                    Positioned(
                      top: 10,
                      right: 60,
                      child: InkWell(
                        onTap: () {
                          Share.share('Apply for volunteer!');
                        },
                        child: Image.asset(
                          'assets/icons/sharing.png', // Path to your custom heart icon in assets
                          width: 22,
                          height: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                // Image.asset(
                                //   'assets/icons/star.png',
                                //   color: Colors.black,
                                //   width: 20,
                                //   height: 20,
                                // ),
                                const SizedBox(
                                  width: 12,
                                ),
                                buildStatusBadge(widget.status),
                                Text(
                                  "${widget.applied.length} applied",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (widget.status == "Hiring" &&
                          !widget.applied.containsKey(majdoorID))
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                              widget.applied[majdoorID] = "Unreviewed";
                              await FirebaseFirestore.instance
                                  .collection("projects")
                                  .doc(widget.projectID)
                                  .update({
                                "applied": widget.applied,
                              });

                              applyVolunteer();
                              setState(() {
                                showLottie = true;
                              });

                              // Simulate a delay
                              Future.delayed(const Duration(seconds: 5), () {
                                setState(() {
                                  showLottie = false;
                                });
                              });
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                            ),
                            child: Text(
                              "Apply for Volunteer",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        )
                      else if (widget.status == "Ongoing")
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: null, // Disabled button
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(Colors
                                  .grey), // Grey color indicates disabled state
                            ),
                            child: Text(
                              "Application Closed",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        )
                      else if (widget.status == "Complete")
                        Center(
                          child: Text(
                            "The project is completed",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "The project",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.description,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 101, 100, 100)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "The need",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.needDescription,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 101, 100, 100)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Lottie Animation (Show it above all widgets in the center)
          if (showLottie)
            Center(
              child: Lottie.asset(
                'assets/animation/animation_lmga7ywu.json', // Replace with your Lottie animation asset
                width: 400,
                height: 400,
                repeat: true,
              ),
            ),
          // Black semi-transparent background when Lottie animation is playing
          if (showLottie)
            Container(
              color: Colors.black.withOpacity(0.3),
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Lottie.asset(
                  'assets/animation/animation_lmga7ywu.json',
                  width: 400,
                  height: 400,
                  repeat: true,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildStatusBadge(String status) {
    Color statusColor;
    switch (status) {
      case "Hiring":
        statusColor = Colors.green;
        break;
      case "Ongoing":
        statusColor = Colors.orange;
        break;
      case "Completed":
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey; // Default color for undefined status
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
