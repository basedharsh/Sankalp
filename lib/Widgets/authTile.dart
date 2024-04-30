import 'package:flutter/material.dart';

class AuthTile extends StatefulWidget {
  final String text;
  final Color myColor;
  final String img;
  final Color textColor;
  AuthTile(
      {required this.text,
      required this.img,
      required this.myColor,
      required this.textColor});
  @override
  State<AuthTile> createState() => _AuthTileState();
}

class _AuthTileState extends State<AuthTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      width: 112,
      height: 120,
      decoration: BoxDecoration(
        color: widget.myColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(widget.img),
          Text(
            widget.text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: widget.textColor),
          )
        ],
      ),
    );
  }
}

class UpdateTileColor with ChangeNotifier {
  Color primaryColor = Colors.white;
  Color selectedColor = Colors.black;

  Color VolunteerTile = Colors.white;
  Color NgoTile = Colors.white;

  Color TextColorVolunteer = Colors.black;
  Color TextColorNgo = Colors.black;

  Color SelectedTextColor = Colors.white;

  String role = "";

  void updateColor({required int index}) {
    if (index == 1) {
      if (VolunteerTile == primaryColor) {
        VolunteerTile = selectedColor;
        NgoTile = primaryColor;
        TextColorVolunteer = SelectedTextColor;
        TextColorNgo = Colors.black;

        notifyListeners();
      } else {
        VolunteerTile = primaryColor;
        notifyListeners();
      }
      role = "Volunteer";
      print(role);
      notifyListeners();
    }
    if (index == 2) {
      if (NgoTile == primaryColor) {
        NgoTile = selectedColor;
        VolunteerTile = primaryColor;
        TextColorNgo = SelectedTextColor;
        TextColorVolunteer = Colors.black;

        notifyListeners();
      } else {
        NgoTile = primaryColor;
        notifyListeners();
      }
      role = "Ngo";
      notifyListeners();
    }

    if (index == 0) {
      VolunteerTile = primaryColor;
      NgoTile = primaryColor;
      TextColorVolunteer = Colors.black;
      TextColorNgo = Colors.black;
      //blah blah

      role = "";
      notifyListeners();
    }
  }
}
