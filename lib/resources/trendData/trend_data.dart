import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotslash/ExtraScreens/trending/tread_page/trend_page.dart';
import 'package:flutter/material.dart';

class TrendingData {
  Future<List<Widget>> fetchtrendingData(BuildContext context) async {
    List<Widget> trendingItems = [];
    await FirebaseFirestore.instance.collection("projects").get().then((value) {
      trendingItems.clear();
      for (var element in value.docs) {
        print(element.data());
        // String cardText = element.data()['project_Image'];
        trendingItems.add(
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return TrendPage(
                      projectImage: element.data()['project_Image'],
                      projectName: element.data()['project_Name'],
                      projectStartDate: element.data()['start_Date'],
                      projectStartTime: element.data()['start_Time'],
                      projectEndDate: element.data()['end_Date'],
                      projectEndTime: element.data()['end_Time'],
                      location: element.data()['project_Location'],
                      projectDescription: element.data()['project_Description'],
                      applied_Count: element.data()['applied_Count'],
                      needDescription: element.data()['project_Need'],
                      projectID: element.id,
                    );
                  },
                ),
              );
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
                      element.data()['project_Image'],
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
                        element.data()['project_Name'],
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
    print(trendingItems);
    return trendingItems;
  }
}
