import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotslash/ExtraScreens/category_list/category_tabs/environment/evno_project/envo_project.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EnvoScreen extends StatefulWidget {
  const EnvoScreen({super.key});

  @override
  State<EnvoScreen> createState() => _EnvoScreenState();
}

class _EnvoScreenState extends State<EnvoScreen> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> envoList = [];

  @override
  void initState() {
    FirebaseFirestore.instance.collection("Environment").get().then((value) {
      if (kDebugMode) {
        print(value.docs[0].data());
      }
      setState(() {
        envoList = value.docs;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: envoList.length,
          itemBuilder: (context, index) {
            return EnvoItem(
              itemData: envoList[index].data(),
              projectID: envoList[index].id,
            );
          },
        ),
      ),
    );
  }
}

class EnvoItem extends StatelessWidget {
  final Map<String, dynamic> itemData;
  final String projectID;

  const EnvoItem({
    super.key,
    required this.itemData,
    required this.projectID,
  });

  void _onReadMorePressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EnvoProject(
          imageUrl: itemData["project_Image"],
          title: itemData["project_Name"],
          location: itemData["project_Location"],
          description:
              itemData["project_Description"], // Pass the description here
          needDescription: itemData["project_Need"],
          startTime: itemData["start_Time"],
          endTime: itemData["end_Time"],
          startDate: itemData["start_Date"],
          endDate: itemData["end_Date"],
          applied_Count: itemData['applied_Count'],
          projectID: projectID,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.network(
            itemData["project_Image"],
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    itemData["project_Name"],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/location.png',
                        color: Colors.black,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        itemData["project_Location"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                itemData["project_Description"],
                style: const TextStyle(
                  color: Color.fromARGB(
                    255,
                    101,
                    100,
                    100,
                  ),
                ),
                maxLines: 5,
                overflow: TextOverflow.fade,
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    _onReadMorePressed(context);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: const Text(
                    "Read more",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
