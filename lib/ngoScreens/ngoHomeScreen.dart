// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotslash/colorScheme.dart';
import 'package:dotslash/ngoScreens/NgoWidgets/NgoProjects.dart';
import 'package:dotslash/ngoScreens/NgoWidgets/ngoDrawer.dart';
import 'package:dotslash/ngoScreens/inivite_upoad.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NgoHomeScreen extends StatefulWidget {
  const NgoHomeScreen({super.key});

  @override
  State<NgoHomeScreen> createState() => _NgoHomeScreenState();
}

String newProjectName = '';
String newProjectImageUrl = '';
String newProjectTime = '';
String newProjectDescription = '';
String newProjectNeed = '';

class _NgoHomeScreenState extends State<NgoHomeScreen> {
  List<Map<String, dynamic>> projects = []; // To store fetched projects

  @override
  void initState() {
    super.initState();
    _fetchProjects();
  }

  Future<void> _fetchProjects() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (userId.isNotEmpty) {
      try {
        var querySnapshot = await FirebaseFirestore.instance
            .collection('projects')
            .where('userId', isEqualTo: userId)
            .get();

        setState(() {
          projects = querySnapshot.docs.map((doc) {
            var data = doc.data();

            return {
              'projectName': data['projectName'] ?? '',
              'projectImage': data['projectImage'] ?? '',
              'projectTime': data['projectTime'] ?? '',
              'projectDescription': data['projectDescription'] ?? '',
              'projectNeed': data['projectNeed'] ?? '',
              "projectStartDate": data["projectStartDate"],
              "projectEndDate": data["projectEndDate"],
              "projectStartTime": data["projectStartTime"],
              "projectEndTime": data["projectEndTime"],
              "applied": data["applied"],
              "karma": data["karma"],
              "status": data["status"],
              "projectId": data["projectId"],
              "tasks": data["tasks"],
            };
          }).toList();

          if (kDebugMode) {
            print("The projects are: $projects");
          }
        });
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching projects: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.BackgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyle.primaryColorYellow,
        title: Text(
          'Sankalp',
          style: TextStyle(color: AppStyle.TextColor1),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: AppStyle.TextColor1,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(
                  Icons.notification_add_outlined,
                  color: AppStyle.TextColor1,
                  size: 40,
                ),
                const SizedBox(
                  width: 20,
                ),
                const CircleAvatar(
                  //Image For Ngo
                  backgroundImage:
                      NetworkImage('https://via.placeholder.com/150'),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: NgoDrawer(),
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          var project = projects[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NgoProjectPage(
                    projectName: project['projectName'],
                    projectImage: project['projectImage'],
                    projectTime: project['projectTime'],
                    projectDescription: project['projectDescription'],
                    projectNeed: project['projectNeed'],
                    projectReviews: "Good", // Manual
                    projectApplied: "", //Manual
                    projectDate: "", //Manual
                    applied: project['applied'],
                    projectId: project['projectId'],
                    tasks: project['tasks'],
                    karma: project['karma'],
                  ),
                ),
              );
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: Container(
                width: double.infinity,
                height: 250,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 0.50),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image.network(
                        project['projectImage'] ?? '',
                        width: double.infinity,
                        height: 165,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            project['projectName'] ?? '',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/icons/star.png',
                                color: Colors.black,
                                width: 14,
                                height: 14,
                              ),
                              const SizedBox(width: 7),
                              Text(
                                project['projectReviews'] ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Project Date',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "${project['projectStartDate'].toString().substring(0, 10)} to ${project['projectEndDate'].toString().substring(0, 10)}",
                                style: const TextStyle(
                                  fontSize: 13,
                                  letterSpacing: 1.2,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Time',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "${project['projectStartTime']} to ${project['projectEndTime']}",
                                style: const TextStyle(
                                  fontSize: 13,
                                  letterSpacing: 1.2,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            project['projectApplied'] ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        clipBehavior: Clip.antiAlias,
        shape: const CircleBorder(),
        backgroundColor: AppStyle.HighlightColor,
        onPressed: () {
          // _showAddProjectModal(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UploadProject(),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
