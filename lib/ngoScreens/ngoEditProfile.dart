import 'package:dotslash/ExtraScreens/homeScreen.dart';
import 'package:dotslash/ngoScreens/ngoBottomNavbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../resources/firebase_auth/auth_controller.dart';

class NgoEditProfile extends StatefulWidget {
  const NgoEditProfile({super.key});

  @override
  State<NgoEditProfile> createState() => _NgoEditProfileState();
}

class _NgoEditProfileState extends State<NgoEditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  AuthController authController = Get.put(AuthController());
  final scaffoldKey = GlobalKey<ScaffoldState>();

  File? selectedImage;

  bool passwordObsured = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = authController.myUser.value.name ?? "";
    contactController.text = authController.myUser.value.phoneNumber ?? "";
    emailController.text = authController.myUser.value.email ?? "";
    locationController.text = authController.myUser.value.location ?? "";
    passwordController.text = authController.myUser.value.password ?? "";
    bioController.text = authController.myUser.value.bio ?? "";
    authController.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 65,
        centerTitle: true,
        title: const Text(
          "My Account",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            letterSpacing: 1,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                ),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.shade500,
                        blurRadius: 4.0,
                        offset: const Offset(
                          1.0,
                          1.0,
                        ),
                      )
                    ],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(60),
                    onTap: _pickImageFromGallery,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      backgroundImage: selectedImage != null
                          ? Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            ).image
                          : const NetworkImage(
                              'https://upload.wikimedia.org/wikipedia/commons/a/af/Default_avatar_profile.jpg',
                            ),
                    ),
                  ),
                ),
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
                        hintText: "Name",
                        hintStyle: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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
                      controller: contactController,
                      maxLength: 10,
                      decoration: InputDecoration(
                        hintText: "Contact",
                        hintStyle: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
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
                            'assets/icons/call.png',
                            width: 20,
                            height: 20,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
                                .hasMatch(value)) {
                          return "Enter correct contact number";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
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
                            'assets/icons/mail.png',
                            width: 20,
                            height: 20,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
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
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          color:
                              passwordObsured ? Colors.black54 : Colors.black,
                          padding: const EdgeInsets.only(right: 15),
                          splashRadius: 120,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              passwordObsured = !passwordObsured;
                            });
                          },
                          icon: Icon(
                            passwordObsured
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
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
                            'assets/icons/unlock.png',
                            width: 20,
                            height: 20,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: passwordObsured,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: locationController,
                      decoration: InputDecoration(
                        hintText: "Location",
                        hintStyle: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        authController.storeUserInfo(
                          selectedImage,
                          url: authController.myUser.value.photoUrl ?? "",
                          nameController.text,
                          emailController.text,
                          contactController.text,
                          locationController.text,
                          passwordController.text,
                          bioController.text,
                        );
                        // authController.storeUserInfo(
                        //   selectedImage,
                        //   url: authController.myUser.value.photoUrl ?? "",
                        //   nameController.text,
                        //   contactController.text,
                        //   emailController.text,
                        //   passwordController.text,
                        //   locationController.text,

                        // );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NgoBottomNavbar(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    print("profile picture");
    final returnedImge =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImge == null) {
      return null;
    }
    setState(() {
      selectedImage = File(returnedImge.path);
    });
  }
}
