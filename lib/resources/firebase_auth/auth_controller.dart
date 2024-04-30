import 'dart:io';
import 'package:dotslash/ExtraScreens/homeScreen.dart';
import 'package:dotslash/models/user_models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:path/path.dart' as Path;

class AuthController extends GetxController {
  var myUser = UserModel().obs;
  void getUserInfo() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var docSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    if (docSnapshot.exists) {
      myUser.value = UserModel.fromJson(docSnapshot.data()!);
      update(); // Ensures UI components listening to changes are updated
    }
  }

  uploadImage(File image) async {
    String imageUrl = '';
    String fileName = Path.basename(image.path);

    var reference = FirebaseStorage.instance.ref().child('users/$fileName');
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    await taskSnapshot.ref.getDownloadURL().then((value) {
      imageUrl = value;
      print('Downloaded URL: $value');
    });
    return imageUrl;
  }

  storeUserInfo(File? selectedImage, String name, String email,
      String phoneNumber, String location, String password, String bio,
      {String url = ''}) async {
    String newUrl = url;
    if (selectedImage != null) {
      newUrl = await uploadImage(
          selectedImage); // Updated to use the correct variable name
    }
    String uid = FirebaseAuth.instance.currentUser!.uid;

    // Update user info
    await FirebaseFirestore.instance.collection("users").doc(uid).update({
      "profile_image": newUrl,
      "username": name,
      "contact": phoneNumber,
      "emailAddress": email,
      "password": password,
      "location": location,
      "bio": bio,
    });

    // After updating, fetch the userType to decide navigation
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
    String userType = userData['userType'] ?? '';
  }
}
