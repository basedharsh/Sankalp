import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotslash/colorScheme.dart';
import 'package:flutter/material.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  List<dynamic> leaderboarddata = [];

  bool loading = false;
  void loadData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .orderBy('karma', descending: true)
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        print(value.docs[i].data()['karma']);
      }
      setState(() {
        leaderboarddata = value.docs;
      });
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (leaderboarddata.length < 3) {
      return Scaffold(
        backgroundColor: AppStyle.HighlightColor,
        body: Center(
          child: Text(
            'Let more users come on board to activate leaderboard',
            style: TextStyle(fontSize: 20, color: AppStyle.bgColor),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return Scaffold(
        backgroundColor: AppStyle.HighlightColor,
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 50,
            ),
            Row(children: [
              //Second User
              Expanded(
                flex: 1,
                child: Container(
                  height: 300,
                  // color: Colors.amber,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 140,
                      ),
                      CircleAvatar(
                        radius: 40.0,
                        backgroundImage: NetworkImage(
                            "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
                        backgroundColor: Colors.transparent,
                      ),
                      Image(image: AssetImage("assets/logo/Award2.png")),
                      Text(
                        leaderboarddata[1].data()['username'],
                        style:
                            TextStyle(fontSize: 20, color: AppStyle.TextColor1),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),

              //First User
              Expanded(
                flex: 2,
                child: Container(
                  // color: Colors.amber,
                  height: 250,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        backgroundColor: Colors.transparent,
                      ),
                      Image(image: AssetImage("assets/logo/Award1.png")),
                      Text(leaderboarddata[0].data()['username'],
                          style: TextStyle(
                              fontSize: 20, color: AppStyle.TextColor1))
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              //Third User
              Expanded(
                flex: 1,
                child: Container(
                  height: 350,
                  // color: Colors.amber,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 140,
                      ),
                      CircleAvatar(
                        radius: 40.0,
                        backgroundImage: NetworkImage(
                            "https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
                        backgroundColor: Colors.transparent,
                      ),
                      Image(image: AssetImage("assets/logo/Award3.png")),
                      Text(leaderboarddata[2].data()['username'],
                          style: TextStyle(
                              fontSize: 20, color: AppStyle.TextColor1))
                    ],
                  ),
                ),
              ),
            ]),
            Center(
              child: Column(
                children: [
                  Text(
                    'Leader-Board',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppStyle.TextColor1),
                  ),
                  Divider(
                    endIndent: 10,
                    indent: 10,
                    thickness: 6,
                    color: AppStyle.TextColor1,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    height: 345,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppStyle.TextColor1,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      itemCount: leaderboarddata.length - 3,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white.withOpacity(0.9),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                'https://via.placeholder.com/150', // Replace with actual image URL
                              ),
                            ),
                            title: Text(leaderboarddata[index + 3]['username']),
                            trailing: Text(
                              leaderboarddata[index + 3]['karma'].toString(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  Widget userCard(
      {required int index,
      required String avatarUrl,
      required String trophyAsset,
      required double radius,
      required double height,
      bool isMainUser = false}) {
    return Expanded(
      flex: isMainUser ? 2 : 1,
      child: Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height),
            CircleAvatar(
              radius: radius,
              backgroundImage: NetworkImage(avatarUrl),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(height: 10), // Spacing between avatar and trophy
            Image.asset(trophyAsset, height: isMainUser ? 60 : 50),
            SizedBox(height: 5), // Spacing between trophy and username
            Text(
              leaderboarddata[index].data()['username'],
              style: TextStyle(
                fontSize: isMainUser ? 18 : 16,
                fontWeight: isMainUser ? FontWeight.bold : FontWeight.normal,
                color: Colors.deepPurple, // Stylish text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
