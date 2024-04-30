import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:lottie/lottie.dart';
import '../../drawer/drawer.dart';
import '../../../Widgets/search_page.dart';

class ProjectPage extends StatefulWidget {
  final String projectImage;
  final String projectName;
  final String projectStartDate;
  final String projectEndDate;
  final String projectEndTime;
  final String projectStartTime;
  final String location;
  final String projectDescription;
  final String needDescription;
  final String projectID;
  final int appliedCount;

  ProjectPage({
    required this.projectImage,
    required this.projectName,
    required this.location,
    required this.projectDescription,
    required this.needDescription,
    required this.projectStartDate,
    required this.projectEndDate,
    required this.projectEndTime,
    required this.projectStartTime,
    required this.projectID,
    required this.appliedCount,
  });
  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  // Function to open the CategoryTabs drawer
  void openCategoryTabsDrawer() {
    Scaffold.of(context).openDrawer();
  }

  bool isLiked = false;
  bool showLottie = false;
  bool isApplied = false; // Add a variable to track the application state

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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.search_rounded,
              color: Colors.black,
              size: 29,
            ),
          ),
        ],
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
                          widget.projectImage,
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
                            widget.projectName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            child: Expanded(
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/location.png',
                                    color: Colors.black,
                                    width: 15,
                                    height: 15,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    widget.location,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      letterSpacing: 0.6,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/icons/calendar.png',
                                width: 15,
                                height: 15,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                '${widget.projectStartDate}  -  ${widget.projectEndDate}',
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 11,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/icons/clock.png',
                                width: 15,
                                height: 15,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${widget.projectStartTime}  -  ${widget.projectEndTime}',
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 11,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (!isApplied) {
                              // Apply for volunteer only if not already applied
                              await FirebaseFirestore.instance
                                  .collection("explore")
                                  .doc(widget.projectID)
                                  .update({
                                "applied_Count": widget.appliedCount + 1,
                              });
                              applyVolunteer();
                            }
                            setState(() {
                              showLottie = true;
                            });

                            // Simulate a delay, you can replace this with actual animation duration
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
                            isApplied ? "Applied" : "Apply for volunteer",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              letterSpacing: 1,
                            ),
                          ),
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
                        widget.projectDescription,
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
}
