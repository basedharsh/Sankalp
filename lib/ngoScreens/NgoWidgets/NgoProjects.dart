import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotslash/colorScheme.dart';
import 'package:dotslash/ngoScreens/NgoWidgets/ProjectApproveCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NgoProjectPage extends StatefulWidget {
  final String projectImage;
  final String projectName;
  final String projectReviews;
  final String projectApplied;
  final String projectDate;
  final String projectTime;
  final String projectDescription;
  final String projectNeed;
  final Map<dynamic, dynamic> applied;
  final String projectId;
  final Map<dynamic, dynamic> tasks;
  final int karma;

  NgoProjectPage({
    required this.projectImage,
    required this.projectName,
    required this.projectReviews,
    required this.projectApplied,
    required this.projectDate,
    required this.projectTime,
    required this.projectDescription,
    required this.projectNeed,
    required this.applied,
    required this.projectId,
    required this.tasks,
    required this.karma,
  });

  @override
  State<NgoProjectPage> createState() => _NgoProjectPageState();
}

class _NgoProjectPageState extends State<NgoProjectPage> {
  List<dynamic> appliedUsersData = [];
  late Map<dynamic, dynamic> tasks = widget.tasks;
  late int karma = widget.karma;
  bool loading = false;
  String status = "";
  List<TextEditingController> taskDescriptionControllers = [];
  List<TextEditingController> karmaPointsControllers = [];

  @override
  void initState() {
    super.initState();
    getAppliedData();
    FirebaseFirestore.instance
        .collection("projects")
        .doc(widget.projectId)
        .get()
        .then((value) {
      setState(() {
        status = value.data()!["status"];
      });
    });
  }

  void getAppliedData() async {
    setState(() {
      loading = true;
    });
    for (int i = 0; i < widget.applied.length; i++) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.applied.keys.toList()[i])
          .get()
          .then((value) {
        setState(() {
          appliedUsersData.add(value.data());
        });
      });
    }
    setState(() {
      loading = false;
    });
    print(appliedUsersData);
  }

  void _addTaskFields() {
    TextEditingController taskDescriptionController = TextEditingController();
    TextEditingController karmaPointsController = TextEditingController();

    setState(() {
      taskDescriptionControllers.add(taskDescriptionController);
      karmaPointsControllers.add(karmaPointsController);
    });
  }

  void _printTaskFieldValues() {
    final db = FirebaseFirestore.instance;
    int totalKarma = 0;
    for (int i = 0; i < taskDescriptionControllers.length; i++) {
      print("Task ${i + 1}:");
      print("Task Description: ${taskDescriptionControllers[i].text}");
      print("Karma Points: ${karmaPointsControllers[i].text}");
      totalKarma = totalKarma + int.parse(karmaPointsControllers[i].text);
      setState(() {
        tasks[taskDescriptionControllers[i].text] =
            karmaPointsControllers[i].text;
        taskDescriptionControllers.clear();
        karmaPointsControllers.clear();
      });
    }
    setState(() {
      karma = karma - totalKarma;
    });
    db.collection("projects").doc(widget.projectId).update({
      "tasks": tasks,
      "karma": FieldValue.increment(-totalKarma),
    });
  }

  @override
  Widget build(BuildContext context) {
    print(status);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
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
                          Row(
                            children: [
                              Image.asset(
                                'assets/icons/star.png',
                                color: Colors.grey,
                                width: 17,
                                height: 17,
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(
                                "${widget.applied.length} applied",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.projectDate,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/clock.png',
                                  color: Colors.grey,
                                  width: 17,
                                  height: 17,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  widget.projectTime,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        child: Card(
                          elevation: 4,
                          margin: const EdgeInsets.all(15),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "The Project",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  widget.projectDescription,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 101, 100, 100),
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "The Need",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  widget.projectNeed,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 101, 100, 100),
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                      (status == "Hiring")
                          ? Column(
                              children: [
                                const Text(
                                  "Applied Volunteers",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                (loading)
                                    ? const SizedBox()
                                    : SizedBox(
                                        height: 400,
                                        child: ListView.builder(
                                          itemCount: widget.applied.length,
                                          itemBuilder: (context, index) {
                                            return StatusCard(
                                              name: appliedUsersData[index]
                                                  ['username'],
                                              imagePath: appliedUsersData[index]
                                                  ['profilePicture'],
                                              status: widget.applied.values
                                                  .toList()[index],
                                              projectId: widget.projectId,
                                              applied: widget.applied,
                                              userID: widget.applied.keys
                                                  .toList()[index],
                                            );
                                          },
                                        ),
                                      ),
                                Center(
                                  child: ElevatedButton(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    onPressed: () {
                                      setState(() {
                                        status = "Ongoing";
                                      });
                                      FirebaseFirestore.instance
                                          .collection("projects")
                                          .doc(widget.projectId)
                                          .update({
                                        "status": "Ongoing",
                                      });
                                    },
                                    child: const Text("Start Project"),
                                  ),
                                )
                              ],
                            )
                          : Column(
                              children: <Widget>[
                                const SizedBox(height: 10),
                                Text(
                                  "$karma Karmas left",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 400,
                                  child: Card(
                                    elevation: 4,
                                    margin: const EdgeInsets.all(18.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Assigned Tasks",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          Divider(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Text("${tasks.length} Tasks",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount: tasks.length,
                                              itemBuilder: (context, index) {
                                                // Determine whether the task's value is 'complete'
                                                bool isComplete = tasks.values
                                                        .toList()[index]
                                                        .toLowerCase() ==
                                                    'complete';

                                                return ListTile(
                                                  title: Text(
                                                    tasks.keys.toList()[index],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  subtitle: Text(isComplete
                                                      ? 'Complete'
                                                      : tasks.values
                                                              .toList()[index] +
                                                          ' Karma'),
                                                  trailing: Icon(
                                                    Icons.check_circle_outline,
                                                    // Change the color based on the task's completion status
                                                    color: isComplete
                                                        ? Colors.green
                                                        : Colors.grey,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: _addTaskFields,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppStyle.secondaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                        ),
                                        child: const Icon(Icons.add),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          _printTaskFieldValues();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text('Task is uploaded'),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppStyle.primaryColorOrange,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                        ),
                                        child: const Text("Upload Tasks"),
                                      ),
                                    ],
                                  ),
                                ),
                                ..._buildTaskFields(),
                              ],
                            ),
                      ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return _buildBottomSheetContent(context);
                              },
                            );
                          },
                          child: Text("Complete"))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTaskFields() {
    List<Widget> taskFields = [];

    for (int i = 0; i < taskDescriptionControllers.length; i++) {
      taskFields.add(
        Column(
          children: <Widget>[
            TextField(
              controller: taskDescriptionControllers[i],
              decoration: const InputDecoration(
                labelText: 'Task Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: karmaPointsControllers[i],
              decoration: const InputDecoration(
                labelText: 'Karma Points',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    }

    return taskFields;
  }

  Widget _buildBottomSheetContent(BuildContext context) {
    TextEditingController textFieldController = TextEditingController();

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Confirm?"),
          // Uncomment and modify if the text field is needed
          // TextField(
          //   controller: textFieldController,
          //   decoration: const InputDecoration(
          //     hintText: 'Any Recommendation?',
          //     border: OutlineInputBorder(),
          //   ),
          // ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Handling the text or other operations
              String enteredText = textFieldController.text;

              // Here, update Firestore and local state to mark the project as Complete
              FirebaseFirestore.instance
                  .collection("projects")
                  .doc(widget.projectId)
                  .update({"status": "Complete"}).then((_) {
                setState(() {
                  status = "Complete"; // Update local status
                });

                // Optional: Show a message or perform other UI updates
                Navigator.of(context).pop(); // Close the bottom sheet
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Project marked as complete."),
                    duration: Duration(seconds: 2),
                  ),
                );
              }).catchError((error) {
                // Handle errors, e.g., display a snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Failed to complete project: $error"),
                  ),
                );
              });
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
