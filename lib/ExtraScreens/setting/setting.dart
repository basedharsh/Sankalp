import 'package:dotslash/Authorization/Login/loginScreen.dart';
import 'package:dotslash/ExtraScreens/drawer/my_account/my_account.dart';
import 'package:dotslash/ExtraScreens/setting/app_version/app_versiom.dart';
import 'package:dotslash/ExtraScreens/setting/help_center/help_center.dart';
import 'package:dotslash/ExtraScreens/setting/notifications/notifications.dart';
import 'package:dotslash/ExtraScreens/setting/password/password.dart';
import 'package:dotslash/ExtraScreens/setting/privacy/privacy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'terms_&_conditions/terms_&_condition.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  // Define a mapping of titles to prefix icons
  final Map<String, String> prefixIcons = {
    "Account": 'assets/icons/user.png',
    "Notification": 'assets/icons/notification.png',
    "Password": 'assets/icons/password.png',
    "Privacy": 'assets/icons/insurance.png',
    "Terms & Conditions": 'assets/icons/t&c.png',
    "Help & Support": 'assets/icons/support.png',
    "App Version": 'assets/icons/update.png',
    "Log Out": 'assets/icons/exit.png',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 65,
        centerTitle: true,
        title: const Text(
          "Setting",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 22,
            letterSpacing: 1.5,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: ListView(
        children: [
          buildListTile(
            "Account",
            "Update profile information.",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyAccount(),
                ),
              );
            },
          ),
          buildListTile(
            "Notification",
            "Do not disturb.",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsPage(),
                ),
              );
            },
          ),
          buildListTile(
            "Password",
            "Reset password.",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PasswordPage(),
                ),
              );
            },
          ),
          buildListTile(
            "Privacy",
            "Privacy preferences.",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPage(),
                ),
              );
            },
          ),
          buildListTile(
            "Terms & Conditions",
            "Terms of service and privacy policy.",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TermsAndCondition(),
                ),
              );
            },
          ),
          buildListTile(
            "Help & Support",
            "Contact support team.",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HelpCenter(),
                ),
              );
            },
          ),
          buildListTile(
            "App Version",
            "App version & information about updates.",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppVersion(),
                ),
              );
            },
          ),
          buildListTile(
            "Log Out",
            "",
            () {
              showDialog(
                context: context,
                builder: (context) {
                  return const CustomLogoutDialog();
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildListTile(String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Image.asset(
        prefixIcons[title]!,
        width: 22,
        height: 22,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 15,
      ), // Suffix icon
      onTap: onTap,
    );
  }
}

class CustomLogoutDialog extends StatelessWidget {
  const CustomLogoutDialog({super.key});

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
