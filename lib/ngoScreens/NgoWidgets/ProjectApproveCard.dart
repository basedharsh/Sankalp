import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotslash/ngoScreens/NgoWidgets/ngoPdf.dart';
import 'package:flutter/material.dart';

class StatusCard extends StatefulWidget {
  final String name;
  final String imagePath;
  final String status;
  final String projectId;
  final Map<dynamic, dynamic> applied;
  final String userID;

  StatusCard(
      {Key? key,
      required this.name,
      required this.imagePath,
      required this.status,
      required this.projectId,
      required this.applied,
      required this.userID})
      : super(key: key);

  @override
  _StatusCardState createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> {
  bool isApproved = false;
  late String status = widget.status;
  late Map<dynamic, dynamic> applied = widget.applied;
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(widget.imagePath),
            radius: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(status),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.check, color: Colors.green),
                        onPressed: () {
                          setState(() {
                            status = "Approved";
                          });
                          applied[widget.userID] = "Approved";
                          db
                              .collection("projects")
                              .doc(widget.projectId)
                              .update({"applied": applied});
                          db.collection("users").doc(widget.userID).update({
                            "projectList":
                                FieldValue.arrayUnion([widget.projectId])
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            status = "Unapproved";
                          });
                          applied[widget.userID] = "Unapproved";
                          db
                              .collection("projects")
                              .doc(widget.projectId)
                              .update({"applied": applied});
                          db.collection("users").doc(widget.userID).update({
                            "projectList":
                                FieldValue.arrayRemove([widget.projectId])
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                downloadAndSavePdfFromUrl(
                        'https://firebasestorage.googleapis.com/v0/b/miniproject-29dc8.appspot.com/o/HarshResume.pdf?alt=media&token=4d4a5d5b-54d9-4bd5-b2c0-60f4f0f8645c')
                    .then((localPath) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfViewerPage(path: localPath),
                    ),
                  );
                });
              },
              child: Text("Open Pdf"))
        ],
      ),
    );
  }
}
