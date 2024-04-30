import 'package:dotslash/Authorization/Login/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

import '../../resources/firebase_auth/auth_controller.dart'; // Import for the BackdropFilter widget

class DrawerScreen extends StatefulWidget {
  final VoidCallback openCategoryTabsDrawer;
  DrawerScreen({
    Key? key,
    required this.openCategoryTabsDrawer, // Initialize the callback
  }) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    authController.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: 260,
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        child: Column(
          children: [
            // Header Drawer
            Material(
              elevation: 5, // Add elevation
              color: Colors.white,
              child: Container(
                height: 200, // Adjust the height as needed
                child: Stack(
                  children: [
                    // Background image or color
                    Positioned.fill(
                      child: Image.network(
                        authController.myUser.value.photoUrl ??
                            'https://upload.wikimedia.org/wikipedia/commons/a/af/Default_avatar_profile.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: 1.0,
                            sigmaY: 1.0), // Adjust blur intensity as needed
                        child: Container(
                          color: Colors.black
                              .withOpacity(0.3), // Adjust opacity as needed
                        ),
                      ),
                    ),
                    // Profile picture

                    Positioned(
                      left: 16, // Adjust left position as needed
                      bottom: 20, // Adjust bottom position as needed
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40, // Adjust the radius as needed
                        backgroundImage: NetworkImage(
                          authController.myUser.value.photoUrl ??
                              'https://upload.wikimedia.org/wikipedia/commons/a/af/Default_avatar_profile.jpg',
                        ), // Replace with your image path
                      ),
                    ),
                    // Text and subtext
                    Positioned(
                      left: 105, // Adjust left position as needed
                      bottom: 50, // Adjust bottom position as needed
                      child: Text(
                        authController.myUser.value.name ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          // Adjust font size as needed
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Close button or other widgets
                    Positioned(
                      right: 0, // Adjust right position as needed
                      top: 0, // Adjust top position as needed
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the drawer
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 13,
            ),
            // Drawer Items
            buildDrawerItem(
              leadingIcon: 'assets/icons/user.png', // Custom asset icon
              title: "My Account",
              routeName:
                  '/my_account', // Specify the route name for My Account page
              context: context, // Pass the context here
            ),
            const Divider(
              thickness: 1, // Increase the thickness
              indent: 20, // Left padding
              endIndent: 60, // Right padding
              color: Color.fromARGB(255, 205, 205, 205),
            ),
            buildDrawerItem(
              leadingIcon: 'assets/icons/add.png', // Custom asset icon
              title: "Invite Volunteers",
              routeName:
                  '/hire_volunteer', // Specify the route name for My Account page

              context: context, // Pass the context here
            ),
            const Divider(
              thickness: 1, // Increase the thickness
              indent: 20, // Left padding
              endIndent: 60, // Right padding
              color: Color.fromARGB(255, 205, 205, 205),
            ),

            buildDrawerItem(
              leadingIcon: 'assets/icons/done.png', // Custom asset icon
              title: "My Projects",
              routeName:
                  '/my_projects', // Specify the route name for My Account page
              context: context, // Pass the context here
            ),
            const Divider(
              thickness: 1, // Increase the thickness
              indent: 20, // Left padding
              endIndent: 60, // Right padding
              color: Color.fromARGB(255, 205, 205, 205),
            ),

            buildDrawerItem(
              leadingIcon: 'assets/icons/calendar.png', // Custom asset icon
              title: "Calendar",
              routeName:
                  '/calendar', // Specify the route name for My Account page
              context: context, // Pass the context here
            ),
            const Divider(
              thickness: 1, // Increase the thickness
              indent: 20, // Left padding
              endIndent: 60, // Right padding
              color: Color.fromARGB(255, 205, 205, 205),
            ),

            buildDrawerItem(
              leadingIcon: 'assets/icons/settings.png', // Custom asset icon
              title: "Settings",
              routeName:
                  '/settings', // Specify the route name for My Account page
              context: context, // Pass the context here
            ),

            // Divider
            const Divider(
              thickness: 1, // Increase the thickness
              indent: 20, // Left padding
              endIndent: 60, // Right padding
              color: Color.fromARGB(255, 205, 205, 205),
            ),

            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0, left: 15),
              child: Row(
                children: [
                  const Icon(
                    Icons.logout_rounded,
                    color: Colors.black87,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomLogoutDialog();
                        },
                      );
                    },
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerItem({
    required String? leadingIcon,
    required String title,
    required String routeName, // Add the routeName parameter
    required BuildContext context, // Add the BuildContext parameter
  }) {
    return Column(
      children: [
        ListTile(
          dense: true, // Reduce the ListTile's height
          leading: leadingIcon != null
              ? Image.asset(
                  leadingIcon,
                  width: 25, // Adjust the image width
                  height: 25, // Adjust the image height
                  color: Colors.black87, // Set the image color
                )
              : const Icon(
                  Icons.clear, // Use any placeholder icon (e.g., clear)
                  size: 0, // Set size to 0 to make it invisible
                ), // No icon
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 15, // Adjust the text size
              fontWeight: FontWeight.w600,
              color: Colors.black87, // Set the text color
            ),
          ),
          onTap: () {
            // Navigate to the respective page when an item is tapped
            if (routeName == '/category_tabs') {
              widget
                  .openCategoryTabsDrawer(); // Call the callback to open the CategoryTabs drawer
            } else {
              Navigator.pushNamed(context, routeName);
            }
          },
          contentPadding: const EdgeInsets.only(
              left: 20, top: 0, bottom: 0, right: 0), // Customize padding
        ),
      ],
    );
  }
}

class CustomLogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: const Text(
          "Logout",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content:
            const Text("Would you like to confirm your decision to log out ?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              // Handle the logout action
              // Add your logout logic here
              // Close the dialog
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: const Text(
              "Logout",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
