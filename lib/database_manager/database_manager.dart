import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DatabaseManager {
  final CollectionReference exploreList =
      FirebaseFirestore.instance.collection('explore');

  Future<void> createUserData(
      String name,
      String image,
      String review,
      String startDate,
      String endDate,
      String startTime,
      String endTime,
      String description,
      String need,
      String uid) async {
    return await exploreList.doc(uid).set({
      'project_Name': name,
      'project_Image': image,
      'project_Review': review,
      'start_Date': startDate,
      'end_Date': endDate,
      'start_Time': startTime,
      'end_Time': endTime,
      'project_Description': description,
      'project_Need': need,
    });
  }

  Future<void> updateUserList(
    String name,
    String image,
    String review,
    String startDate,
    String endDate,
    String startTime,
    String endTime,
    String description,
    String need,
    String uid,
  ) async {
    return await exploreList.doc(uid).update({
      'project_Name': name,
      'project_Image': image,
      'project_Review': review,
      'start_Date': startDate,
      'end_Date': endDate,
      'start_Time': startTime,
      'end_Time': endTime,
      'project_Description': description,
      'project_Need': need,
    });
  }

  Future getUsersList() async {
    List itemsList = [];

    try {
      await exploreList.get().then((querySnapshot) {
        for (var documentSnapshot in querySnapshot.docs) {
          itemsList.add(documentSnapshot.data());
        }
      });
      return itemsList;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }
}
