import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VolunteerProjectScreen extends StatefulWidget {
  final Map<String, dynamic> projectData;
  const VolunteerProjectScreen({super.key, required this.projectData});

  @override
  State<VolunteerProjectScreen> createState() => _VolunteerProjectScreenState();
}

class _VolunteerProjectScreenState extends State<VolunteerProjectScreen> {
  @override
  Widget build(BuildContext context) {
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
                          widget.projectData["projectImage"],
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
                            widget.projectData["projectName"],
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
                                "${widget.projectData["applied"].length} applied",
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
                            widget.projectData["projectStartDate"],
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
                                  widget.projectData["projectStartTime"],
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
                      const SizedBox(
                        height: 30,
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
                        widget.projectData["projectDescription"],
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
                        widget.projectData["projectNeed"],
                        style: const TextStyle(
                            color: Color.fromARGB(255, 101, 100, 100)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 300,
                        child: ListView.builder(
                            itemCount: widget.projectData["tasks"].keys.length,
                            itemBuilder: (context, index) {
                              if (widget.projectData["tasks"].values
                                      .toList()[index] !=
                                  "Complete") {
                                return Row(
                                  children: [
                                    Text(
                                      "${widget.projectData["tasks"].keys.toList()[index]}",
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return _buildBottomSheetContent(
                                                  context,
                                                  widget
                                                      .projectData["projectId"],
                                                  index,
                                                  int.parse(widget
                                                      .projectData["tasks"]
                                                      .values
                                                      .toList()[index]));
                                            },
                                          );
                                        },
                                        child: Text(
                                            " Complete For ${widget.projectData["tasks"].values.toList()[index]}"))
                                  ],
                                );
                              } else {
                                return const SizedBox();
                              }
                            }),
                      )
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

  Widget _buildBottomSheetContent(
      BuildContext context, String projectID, int index, int value) {
    TextEditingController textFieldController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: textFieldController,
            decoration: const InputDecoration(
              hintText: 'Enter Documents Link',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Do something with the text
              String enteredText = textFieldController.text;
              print('Entered Text: $enteredText');
              FirebaseFirestore.instance
                  .collection("projects")
                  .doc(projectID)
                  .update({
                "tasks.${widget.projectData["tasks"].keys.toList()[index]}":
                    "Complete"
              });
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .update({"karma": FieldValue.increment(value)});

              // Close the bottom sheet
              Navigator.of(context).pop();
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
