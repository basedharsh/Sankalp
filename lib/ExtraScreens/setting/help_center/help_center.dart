import 'package:flutter/material.dart';

class HelpCenter extends StatelessWidget {
  HelpCenter({super.key});
  final Map<String, String> prefixIcons = {
    "Help & Support": 'assets/icons/support.png',
    "Contact us": 'assets/icons/phone.png',
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
          "Help & Support",
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
            "Help & Support",
            "",
            () {},
          ),
          buildListTile(
            "Contact us",
            "Questions? Need help?",
            () {},
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
        width: 25,
        height: 25,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
      ), // Suffix icon
      onTap: onTap,
    );
  }
}
