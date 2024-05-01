import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VolunteerListPage extends StatefulWidget {
  final String projectId;

  const VolunteerListPage({
    Key? key,
    required this.projectId,
  }) : super(key: key);

  @override
  _VolunteerListPageState createState() => _VolunteerListPageState();
}

class _VolunteerListPageState extends State<VolunteerListPage> {
  List<Map<String, dynamic>> volunteerData = [];

  @override
  void initState() {
    super.initState();
    // Retrieve volunteer data for the specified project ID
    fetchVolunteerData();
  }

  void fetchVolunteerData() async {
    // Fetch volunteer data from Firestore based on the project ID
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('projects')
        .doc(widget.projectId)
        .collection('volunteers')
        .get();
    // Process the snapshot to extract volunteer information
    List<Map<String, dynamic>> volunteers =
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    // Set state to update UI with volunteer data
    setState(() {
      volunteerData = volunteers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteers'),
      ),
      body: ListView.builder(
        itemCount: volunteerData.length,
        itemBuilder: (context, index) {
          // Customize the appearance of each volunteer item
          return ListTile(
            title: Text(volunteerData[index]['name'] ?? ''),
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(volunteerData[index]['profilePic'] ?? ''),
            ),
          );
        },
      ),
    );
  }
}
