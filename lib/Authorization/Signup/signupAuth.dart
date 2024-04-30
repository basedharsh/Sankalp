// ignore_for_file: file_names, use_build_context_synchronously

import 'package:dotslash/ngoScreens/uploadNgoCertificate.dart';
import 'package:dotslash/volunteerScreen/volunteeerBottomNav.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:volunteer_app/home/home_screen.dart';

class SignupAuthorization with ChangeNotifier {
  UserCredential? userCredential;
  bool loading = false;

  void signupValidation(
      {required TextEditingController? username,
      required TextEditingController? emailAddress,
      required TextEditingController? password,
      required String? userType,
      required BuildContext context}) async {
    if (username!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("User Name is Empty")));
      return;
    } else if (emailAddress!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email Address is Empty")));
      return;
    } else if (password!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Password is Empty")));
      return;
    } else if (userType == "") {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Select a user type")));
      return;
    } else {
      try {
        loading = true;
        notifyListeners();
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailAddress.text, password: password.text);

        loading = true;
        notifyListeners();

        FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential!.user!.uid)
            .set(
          {
            "username": username.text,
            "emailAddress": emailAddress.text,
            "userUID": userCredential!.user!.uid,
            "userType": userType,
            "status": (userType == "Volunteer") ? "Volunteer" : "Unreviewed",
            "pdfUrl": "",
            "profilePicture":
                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
            "projectList": [],
            "postList": [],
            "karma": 0,
          },
        ).then((value) {
          loading = false;
          notifyListeners();

          if (userType == "Volunteer") {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => VolunteerBottomNav(),
              ),
            );
          } else if (userType == "Ngo") {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UploadPDFPage(),
              ),
            );
          }
        });
      } on FirebaseAuthException catch (e) {
        loading = false;
        notifyListeners();

        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Enter a strong Password"),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("The Email is already inuse"),
            ),
          );
        }
      }
    }
  }
}
