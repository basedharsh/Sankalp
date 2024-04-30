import 'package:flutter/material.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 65,
        centerTitle: true,
        title: const Text(
          "App Version",
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Volunteer Application",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Version 0.0.1",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 15,
                letterSpacing: 1.5,
              ),
            ),
            Image.asset("assets/logo/v_logo.png"),
            const Text(
              "© 2020 - 2023 Volunteer Inc",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 15,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // Add your action here when the button is pressed
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Button background color
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(25.0), // Circular border radius
                ),
                minimumSize: const Size(140, 50), // Button width and height
              ),
              child: const Text('Licenses'),
            ),
          ],
        ),
      ),
    );
  }
}
