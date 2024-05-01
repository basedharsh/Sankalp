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
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .orderBy('karma', descending: true)
          .get();

      setState(() {
        leaderboarddata = querySnapshot.docs;
      });
    } catch (e) {
      print('Error loading data: $e');
      // Handle error gracefully, e.g., show an error message to the user
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Filter out users with userType 'Ngo'
    List<dynamic> filteredData = leaderboarddata
        .where((user) => user.data()['userType'] != 'Ngo')
        .toList();

    if (filteredData.length < 3) {
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
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                // Second User
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 300,
                    child: Column(
                      children: [
                        SizedBox(height: 140),
                        CircleAvatar(
                          radius: 40.0,
                          backgroundImage: leaderboarddata[1]
                                      .data()['profile_image'] !=
                                  null
                              ? NetworkImage(
                                  leaderboarddata[1].data()['profile_image'])
                              : AssetImage("assets/logo/defaultprofilepic.png")
                                  as ImageProvider,
                          backgroundColor: Colors.transparent,
                        ),
                        Image(image: AssetImage("assets/logo/Award2.png")),
                        Text(
                          leaderboarddata[1].data()['username'],
                          style: TextStyle(
                              fontSize: 20, color: AppStyle.TextColor1),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // First User
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 250,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40.0,
                          backgroundImage: leaderboarddata[0]
                                      .data()['profile_image'] !=
                                  null
                              ? NetworkImage(
                                  leaderboarddata[0].data()['profile_image'])
                              : AssetImage("assets/logo/defaultprofilepic.png")
                                  as ImageProvider,
                          backgroundColor: Colors.transparent,
                        ),
                        Image(image: AssetImage("assets/logo/Award1.png")),
                        Text(
                          leaderboarddata[0].data()['username'],
                          style: TextStyle(
                              fontSize: 20, color: AppStyle.TextColor1),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // Third User
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 350,
                    child: Column(
                      children: [
                        SizedBox(height: 140),
                        CircleAvatar(
                          radius: 40.0,
                          backgroundImage: leaderboarddata[2]
                                      .data()['profile_image'] !=
                                  null
                              ? NetworkImage(
                                  leaderboarddata[2].data()['profile_image'])
                              : AssetImage("assets/logo/defaultprofilepic.png")
                                  as ImageProvider,
                          backgroundColor: Colors.transparent,
                        ),
                        Image(image: AssetImage("assets/logo/Award3.png")),
                        Text(
                          leaderboarddata[2].data()['username'],
                          style: TextStyle(
                              fontSize: 20, color: AppStyle.TextColor1),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
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
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      itemCount: leaderboarddata.length - 3,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white.withOpacity(0.9),
                          child: ListTile(
                            leading: const CircleAvatar(
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
      child: SizedBox(
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
            const SizedBox(height: 10), // Spacing between avatar and trophy
            Image.asset(trophyAsset, height: isMainUser ? 60 : 50),
            const SizedBox(height: 5), // Spacing between trophy and username
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
