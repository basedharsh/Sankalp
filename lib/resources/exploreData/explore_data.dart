import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotslash/ExtraScreens/search/read_project/read_project.dart';
import 'package:flutter/material.dart';

class ExploreData {
  Future<List<Widget>> fetchExploreData(BuildContext context) async {
    List<Widget> exploreItems = [];
    await FirebaseFirestore.instance.collection("projects").get().then((value) {
      for (var element in value.docs) {
        print("explore data");
        print(element.data());
        String cardText = element.data()['projectImage'];
        exploreItems.add(
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ReadProject(
                  imageUrl: element.data()['projectImage'],
                  title: element.data()['projectName'],
                  reviewCount: 0,
                  description: element.data()['projectDescription'],
                  needDescription: element.data()['projectNeed'],
                  applied: element.data()['applied'],
                  projectID: element.data()['projectId'],
                  status: element.data()['status'],
                );
              }));
            },
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      cardText,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15.0),
                          bottomLeft: Radius.circular(15.0),
                        ),
                      ),
                      child: Text(
                        element.data()['projectName'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
    return exploreItems;
  }
}
