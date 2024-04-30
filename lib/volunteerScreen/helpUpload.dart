import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class HelpUploadScreen extends StatefulWidget {
  const HelpUploadScreen({super.key});

  @override
  State<HelpUploadScreen> createState() => _HelpUploadScreenState();
}

class _HelpUploadScreenState extends State<HelpUploadScreen> {
  bool _serviceEnabled = false;
  Location location = Location();
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  LocationData? _locationData;
  StreamSubscription<LocationData>? locationSubscription;
  var lat;
  var long;

  Future<dynamic> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////
  TextEditingController postTitle = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController needsController = TextEditingController();
  File? selectedImage;
  void uploadPicture() async {
    final profilePicUpdate =
        FirebaseStorage.instance.ref().child("Project/${uuid.v1()}");
    // FilePickerResult? result = await FilePicker.platform.pickFiles();
    // File file = File(result!.files.single.path!);
    // print(file.path);
    // print(file);
    // _pickImageFromGallery();

    try {
      profilePicUpdate
          .putFile(selectedImage!)
          .snapshotEvents
          .listen((taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            break;
          case TaskState.paused:
            break;
          case TaskState.success:
            String link = await profilePicUpdate.getDownloadURL();
            String postID = uuid.v1();
            await FirebaseFirestore.instance
                .collection("help")
                .doc(postID)
                .set({
              'title': postTitle.text,
              'description': desController.text,
              'latitude': lat.toString(),
              'longitude': long.toString(),
              'image': link,
            }).then((value) {
              Navigator.pop(context);
            });

            // await FirebaseFirestore.instance
            //     .collection("posts")
            //     .doc(postID)
            //     .set(newPost)
            //     .then((value) {
            //   print("Post uploaded");
            //   Navigator.pop(context);
            //   Navigator.pushReplacement(context,
            //       MaterialPageRoute(builder: (context) {
            //     return NgoBottomNavbar();
            //   }));
            // });
            break;
          case TaskState.canceled:
            break;
          case TaskState.error:
            break;
        }
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future _pickImageFromGallery() async {
    final returnedImge =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImge == null) {
      return null;
    }
    setState(() {
      selectedImage = File(returnedImge.path);
      print(selectedImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                ElevatedButton(
                    onPressed: () async {
                      await getLocation().then((value) {
                        print(value);
                        lat = value.latitude;
                        long = value.longitude;
                        print(value.latitude);
                        print(value.longitude);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Location Noted")));
                      });
                      // userLocation = await _getUserLocation();
                      // print(
                      //     'User Location: ${userLocation.latitude}, ${userLocation.longitude}');
                    },
                    child: const Text("Get Location")),
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
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    uploadPicture();
                  },
                  child: const Text("Upload"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
