import 'package:dotslash/ngoScreens/ngoBottomNavbar.dart';
import 'package:dotslash/ngoScreens/ngoHomeScreen.dart';
import 'package:dotslash/ngoScreens/ngoNotApproved.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';

class UploadPDFPage extends StatefulWidget {
  @override
  _UploadPDFPageState createState() => _UploadPDFPageState();
}

class _UploadPDFPageState extends State<UploadPDFPage> {
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
      String fileName = result.files.single.name;

      try {
        TaskSnapshot taskSnapshot = await FirebaseStorage.instance
            .ref('uploads/$fileName')
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
            print(e);
          }
        }

        setState(() {
          isUploaded = true;
          pdfLink = downloadURL;
          isLoading = false;
        });

        print('PDF Link: $pdfLink');
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload PDF to Firebase'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (isUploaded) Text('Uploaded!'),
                  ElevatedButton(
                    onPressed: uploadPDF,
                    child: Text('Upload PDF'),
                  ),
                  if (isUploaded)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NgoNotApproved()));
                      },
                      child: Text('Go to Next Page'),
                    ),
                ],
              ),
      ),
    );
  }
}
