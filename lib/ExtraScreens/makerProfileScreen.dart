// ignore_for_file: file_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotslash/Api/api.dart';
import 'package:dotslash/volunteerScreen/volunteeerBottomNav.dart';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
// import 'package:volunteer_app/api/apiResponse.dart';

class VolunteerMakeProfileScreen extends StatefulWidget {
  const VolunteerMakeProfileScreen({super.key});

  @override
  State<VolunteerMakeProfileScreen> createState() =>
      _VolunteerMakeProfileScreenState();
}

class _VolunteerMakeProfileScreenState
    extends State<VolunteerMakeProfileScreen> {
  TextEditingController githubName = TextEditingController();
  bool isUploaded = false;
  String pdfLink = '';
  bool isLoading = false;

  Future<void> uploadPDF() async {
    setState(() {
      isLoading = true;
    });
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);

      try {
        TaskSnapshot taskSnapshot = await FirebaseStorage.instance
            .ref('uploads/${FirebaseAuth.instance.currentUser!.uid}.pdf')
            .putFile(file);

        String downloadURL = await taskSnapshot.ref.getDownloadURL();
        User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          try {
            String downloadURL = await taskSnapshot.ref.getDownloadURL();
            await FirebaseFirestore.instance
                .collection('users')
                .doc(currentUser.uid)
                .update({
              'pdfUrl': downloadURL,
            });
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
          }
        }

        setState(() {
          isUploaded = true;
          pdfLink = downloadURL;
          isLoading = false;
        });

        if (kDebugMode) {
          print('PDF Link: $pdfLink');
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Make Profile Screen"),
          TextFormField(
            controller: githubName,
            decoration: InputDecoration(
              hintText: "Github Username",
              hintStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 5.0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          ElevatedButton(
            onPressed: uploadPDF,
            child: const Text('Upload PDF'),
          ),
          ElevatedButton(
              onPressed: () async {
                if (kDebugMode) {
                  print(pdfLink);
                }
                String encodedUrl = Uri.encodeFull(pdfLink);
                String url =
                    "http://10.0.2.2:5000/profileGenerate?username=${githubName.text}&userid=${FirebaseAuth.instance.currentUser!.uid}&resumelink=$encodedUrl";
                Uri uri = Uri.parse(url);
                var jsonData = await apiResponse(uri);
                var decodedData = jsonDecode(jsonData);
                if (kDebugMode) {
                  print(decodedData);
                }
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({
                  "profileData": decodedData,
                }).then((value) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VolunteerBottomNav()));
                });
              },
              child: const Text("Get Started")),
        ],
      )),
    );
  }
}
