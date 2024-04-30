import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotslash/Authorization/Login/loginScreen.dart';
import 'package:dotslash/colorScheme.dart';
import 'package:dotslash/ngoScreens/NgoConstants/Constant.dart';
import 'package:dotslash/ngoScreens/NgoWidgets/NgoProjects.dart';
import 'package:dotslash/ngoScreens/NgoWidgets/ngoDrawer.dart';
import 'package:dotslash/ngoScreens/inivite_upoad.dart';
import 'package:dotslash/ExtraScreens/drawer/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
            var data = doc.data() as Map<String, dynamic>;

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

          print("The projects are: $projects");
        });
      } catch (e) {
        print('Error fetching projects: $e');
      }
    }
  }

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
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(
                  Icons.notification_add_outlined,
                  color: AppStyle.TextColor1,
                  size: 40,
                ),
                SizedBox(
                  width: 20,
                ),
                CircleAvatar(
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
                                project['projectStartDate']
                                            .toString()
                                            .substring(0, 10) +
                                        " to " +
                                        project['projectEndDate']
                                            .toString()
                                            .substring(0, 10) ??
                                    "" ??
                                    '',
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
                                project['projectStartTime'].toString() +
                                        " to " +
                                        project['projectEndTime'].toString() ??
                                    '',
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
              builder: (context) => UploadProject(),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showAddProjectModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Wrap(
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Project Name'),
                onChanged: (value) {
                  newProjectName = value;
                },
              ),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Project Image URL'),
                onChanged: (value) {
                  newProjectImageUrl = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Project Time'),
                onChanged: (value) {
                  newProjectTime = value;
                },
              ),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Project Description'),
                onChanged: (value) {
                  newProjectDescription = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Project Need'),
                onChanged: (value) {
                  newProjectNeed = value;
                },
              ),
              ElevatedButton(
                child: const Text('Add Project'),
                onPressed: () async {
                  String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
                  // Create a new project map
                  Map<String, String> newProject = {
                    'userId': userId,
                    'projectName': newProjectName,
                    'projectImage': newProjectImageUrl,
                    'projectTime': newProjectTime,
                    'projectDescription': newProjectDescription,
                    'projectNeed': newProjectNeed,
                    // Add other details as necessary
                  };

                  // Save to Firestore in a separate collection (e.g., 'projects')
                  try {
                    DocumentReference projectRef = await FirebaseFirestore
                        .instance
                        .collection('projects')
                        .add(newProject);

                    // Get the current user's ID (ensure user is logged in and user ID is available)
                    String userId =
                        FirebaseAuth.instance.currentUser?.uid ?? '';

                    // Add the project reference to the user's document in 'users' collection
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(userId)
                        .update({
                      'projectList': FieldValue.arrayUnion([
                        projectRef.id
                      ]) // Add the project ID to the user's project list
                    });

                    // Update the local list if Firestore write was successful
                    setState(() {
                      projectName.add(newProjectName);
                      projectImage.add(newProjectImageUrl);
                      projectTime.add(newProjectTime);
                      projectDetails[newProjectName] = newProject;
                      projects.add(projectDetails);
                    });
                  } catch (e) {
                    print("Error adding project to Firestore: $e");
                  }

                  Navigator.of(context).pop(); // Close the modal sheet
                },
              )
            ],
          ),
        );
      },
    );
  }
}
