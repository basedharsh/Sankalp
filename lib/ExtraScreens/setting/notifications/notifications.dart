import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool doNotDisturb = false; // Initial state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 65,
        centerTitle: true,
        title: const Text(
          "Notifications",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  const Expanded(
                    child: Text("Do not disturb"),
                  ),
                  Switch(
                    activeColor: Colors.black,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.black12,
                    value: doNotDisturb,
                    onChanged: (newValue) {
                      setState(() {
                        doNotDisturb = newValue;
                      });
                    },
                  ),
                ],
              ),
              subtitle: Text(
                doNotDisturb ? "On" : "Off",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
