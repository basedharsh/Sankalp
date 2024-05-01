// ignore_for_file: file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotslash/ngoScreens/ngoBottomNavbar.dart';
import 'package:dotslash/volunteerScreen/volunteeerBottomNav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class UploadFeed extends StatefulWidget {
  const UploadFeed({super.key});

  @override
  State<UploadFeed> createState() => _UploadFeedState();
}

class _UploadFeedState extends State<UploadFeed> {
  TextEditingController postTitle = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController needsController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String projectImageLink = "";
  String userID = FirebaseAuth.instance.currentUser!.uid;

  File? selectedImage;
  void uploadPicture() async {
    if (selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No image selected!")),
      );
      return;
    }

    final profilePicUpdate =
        FirebaseStorage.instance.ref().child("Project/${uuid.v1()}");

    try {
      // Upload the image and get the download URL
      String link = await profilePicUpdate.putFile(selectedImage!).then(
            (snapshot) => snapshot.ref.getDownloadURL(),
          );

      // Fetch user data and create post
      DocumentSnapshot userDocSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .get();
      if (!userDocSnapshot.exists) {
        throw Exception("User not found!");
      }
      Map<String, dynamic> userDocData =
          userDocSnapshot.data() as Map<String, dynamic>;
      String username = userDocData['username'] ?? 'Anonymous';
      String userType = userDocData['userType'] ?? '';

      // Create new post
      Map<String, dynamic> newPost = {
        "postTitle": postTitle.text,
        "postDescription": desController.text,
        "postTime": DateTime.now().toString(),
        "postImage": link,
        "likes": [],
        "userID": userID,
        "username": username,
        "postID": uuid.v1(),
      };

      await FirebaseFirestore.instance.collection('posts').add(newPost);

      navigateBasedOnUserType(userType);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to upload post: $e")),
      );
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void navigateBasedOnUserType(String userType) {
    if (userType == 'Ngo') {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const NgoBottomNavbar()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => VolunteerBottomNav()));
    }
  }

  final List<String> projectTypes = [
    'Educational',
    'Environmental',
    'Health',
    'Charity',
    'International NGOs',
    'City-wide NGOs',
    'Human rights',
    'Medical aid',
    'Community development',
    'Fundraiser',
    'Service'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xffF1F4F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 65,
        automaticallyImplyLeading: false,
        leading: IconButton(
          color: Colors.transparent,
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF252525),
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Post ',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            letterSpacing: 1,
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              'Save',
              style: TextStyle(
                color: Color(0xFFFF0083),
              ),
            ),
            onPressed: () {
              if (kDebugMode) {
                print(selectedImage);
              }
              uploadPicture();
            },
          ),
        ],
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 41, vertical: 22),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: _pickImageFromGallery,
                      child: DottedBorder(
                        strokeWidth: 2,
                        color: Colors.grey,
                        borderType: BorderType.RRect,
                        padding: const EdgeInsets.all(8),
                        radius: const Radius.circular(20),
                        dashPattern: const [3, 3, 3, 3],
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(
                            width: 260,
                            height: 130,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: selectedImage != null
                                  ? Image.file(
                                      selectedImage!,
                                      fit: BoxFit.cover,
                                    )
                                  : const Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.cloud_upload_outlined,
                                          color: Color(0xFF777777),
                                          size: 22,
                                        ),
                                        Text(
                                          'Upload Images',
                                          style: TextStyle(
                                            color: Color(0xFF777777),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 310,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: postTitle,
                        decoration: InputDecoration(
                          hintText: "Post Title",
                          hintStyle: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
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
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              'assets/icons/user.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        autofocus: false,
                        textCapitalization: TextCapitalization.sentences,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: desController,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: "Post description",
                          hintStyle: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
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
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              'assets/icons/cv.png',
                              width: 21,
                              height: 21,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        keyboardType: TextInputType.text,
                        maxLines: null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImge =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImge == null) {
      return null;
    }
    setState(() {
      selectedImage = File(returnedImge.path);
      if (kDebugMode) {
        print(selectedImage);
      }
    });
  }
}
