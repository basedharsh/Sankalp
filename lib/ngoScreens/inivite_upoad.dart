// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:dotslash/ngoScreens/ngoBottomNavbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class UploadProject extends StatefulWidget {
  const UploadProject({super.key});

  @override
  State<UploadProject> createState() => _UploadProjectState();
}

class _UploadProjectState extends State<UploadProject> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController needsController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String projectImageLink = "";
  String userID = FirebaseAuth.instance.currentUser!.uid;

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
            projectImageLink = link;
            if (kDebugMode) {
              print(projectImageLink);
            }
            if (kDebugMode) {
              print("asdfg");
            }
            String projectID = uuid.v1();
            Map<String, dynamic> newProject = {
              'userId': userID,
              'projectName': nameController.text,
              'projectImage': projectImageLink,
              'projectGoal': projectGoal!,
              'projectDescription': desController.text,
              'projectNeed': needsController.text,
              "projectLocation": locationController.text,
              "projectId": projectID,
              "projectStartDate": startDate.toString(),
              "projectEndDate": endDate.toString(),
              "projectStartTime": startTime.format(context),
              "projectEndTime": endTime.format(context),
              "karma": 1000,
              "applied": {},
              "status": "Hiring",
              "tasks": {},
            };
            await FirebaseFirestore.instance
                .collection('users')
                .doc(userID)
                .update({
              'projectList': FieldValue.arrayUnion(
                  [projectID]) // Add the project ID to the user's project list
            });

            await FirebaseFirestore.instance
                .collection("projects")
                .doc(projectID)
                .set(newProject)
                .then((value) {
              if (kDebugMode) {
                print("Project uploaded");
              }
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const NgoBottomNavbar();
              }));
            });
            break;
          case TaskState.canceled:
            break;
          case TaskState.error:
            break;
        }
      });
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
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
  String? projectGoal;
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

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
          'Invite Volunteers',
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
            onPressed: () async {
              uploadPicture();
              // print("asdfg");
              // String projectID = uuid.v1();
              // Map<String, String> newProject = {
              //   'userId': userID,
              //   'projectName': nameController.text,
              //   'projectImage': projectImageLink,
              //   'projectGoal': projectGoal!,
              //   'projectDescription': desController.text,
              //   'projectNeed': needsController.text,
              //   "projectLocation": locationController.text,
              //   "projectId": projectID,
              //   "projectStartDate": startDate.toString(),
              //   "projectEndDate": endDate.toString(),
              //   "projectStartTime": startTime.format(context),
              //   "projectEndTime": endTime.format(context),
              // };
              // await FirebaseFirestore.instance
              //     .collection('users')
              //     .doc(userID)
              //     .update({
              //   'projectList': FieldValue.arrayUnion([
              //     projectID
              //   ]) // Add the project ID to the user's project list
              // });

              // await FirebaseFirestore.instance
              //     .collection("projects")
              //     .doc(projectID)
              //     .set(newProject)
              //     .then((value) {
              //   print("Project uploaded");
              //   Navigator.pop(context);
              // });
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
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Project name",
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
                        height: 20,
                      ),
                      TextFormField(
                        controller: locationController,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: "Project location",
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
                              'assets/icons/location.png',
                              width: 20,
                              height: 20,
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
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                  .hasMatch(value)) {
                            return "Enter correct email address";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black54,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: const Row(
                              children: [
                                Icon(
                                  Icons.filter_list_rounded,
                                  size: 23,
                                  color: Colors.black87,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    'Select Goal',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            items: projectTypes
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: projectGoal,
                            onChanged: (String? value) {
                              setState(() {
                                projectGoal = value;
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              height: 55,
                              width: 310,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_forward_ios_outlined,
                              ),
                              iconSize: 14,
                              iconEnabledColor: Colors.black87,
                              iconDisabledColor: Colors.grey,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 300,
                              width: 330,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              offset: const Offset(-20, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all<double>(6),
                                thumbVisibility:
                                    MaterialStateProperty.all<bool>(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 50,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Project Date',
                            style: TextStyle(
                              fontSize: 13,
                              letterSpacing: 1.5,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          Text(
                            'Project Time',
                            style: TextStyle(
                              fontSize: 13,
                              letterSpacing: 1.5,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 310,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showCustomDateRangePicker(
                                    context,
                                    dismissible: true,
                                    minimumDate: DateTime.now()
                                        .subtract(const Duration(days: 30)),
                                    maximumDate: DateTime.now()
                                        .add(const Duration(days: 190)),
                                    endDate: endDate,
                                    startDate: startDate,
                                    backgroundColor: Colors.white,
                                    primaryColor: Colors.black87,
                                    onApplyClick: (start, end) {
                                      setState(() {
                                        endDate = end;
                                        startDate = start;
                                      });
                                    },
                                    onCancelClick: () {
                                      setState(() {
                                        endDate = null;
                                        startDate = null;
                                      });
                                    },
                                  );
                                },
                                child: Container(
                                  width: 120,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black54,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        startDate != null
                                            ? DateFormat("dd MMM")
                                                .format(startDate!)
                                            : 'Begin',
                                        style: TextStyle(
                                          color: startDate != null
                                              ? Colors.black
                                              : Colors.grey[800],
                                          fontWeight: FontWeight.w500,
                                          fontSize: startDate != null ? 16 : 15,
                                        ),
                                      ),
                                      const Text('~'),
                                      Text(
                                        endDate != null
                                            ? DateFormat("dd MMM")
                                                .format(endDate!)
                                            : 'End',
                                        style: TextStyle(
                                          color: startDate != null
                                              ? Colors.black
                                              : Colors.grey[800],
                                          fontWeight: FontWeight.w500,
                                          fontSize: startDate != null ? 16 : 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  TimeRange? result = await showTimeRangePicker(
                                      context: context,
                                      start:
                                          const TimeOfDay(hour: 2, minute: 0),
                                      end: const TimeOfDay(hour: 5, minute: 0),
                                      disabledTime: TimeRange(
                                          startTime: const TimeOfDay(
                                              hour: 24, minute: 0),
                                          endTime: const TimeOfDay(
                                              hour: 0, minute: 0)),
                                      disabledColor:
                                          Colors.red.withOpacity(0.8),
                                      strokeWidth: 4,
                                      ticks: 12,
                                      ticksOffset: -7,
                                      ticksLength: 15,
                                      ticksColor: Colors.grey,
                                      handlerColor: Colors.black,
                                      selectedColor: Colors.black26,
                                      strokeColor: Colors.black,
                                      labels: [
                                        "12 am",
                                        "2 am",
                                        "4 am",
                                        "6 am",
                                        "8 am",
                                        "10 am",
                                        "12 pm",
                                        "2 pm",
                                        "4 pm",
                                        "6 pm",
                                        "8 pm",
                                        "10 pm"
                                      ].asMap().entries.map((e) {
                                        return ClockLabel.fromIndex(
                                            idx: e.key,
                                            length: 12,
                                            text: e.value);
                                      }).toList(),
                                      labelOffset: 35,
                                      rotateLabels: false,
                                      padding: 60);

                                  if (kDebugMode) {
                                    print("result ${result!.startTime}");
                                    print("result ${result.endTime}");
                                    print(startTime);
                                    setState(() {
                                      startTime = result.startTime;
                                      endTime = result.endTime;
                                    });
                                  }
                                },
                                child: Container(
                                  width: 120,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black54,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        startTime.format(context),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const Text('~'),
                                      Text(
                                        endTime.format(context),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: desController,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: "Project description",
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
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: needsController,
                        textAlign: TextAlign.start,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: "Project needs",
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
                              'assets/icons/need.png',
                              width: 19,
                              height: 19,
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
                        keyboardType: TextInputType.emailAddress,
                        maxLines: null,
                      ),
                      const SizedBox(
                        height: 16,
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
