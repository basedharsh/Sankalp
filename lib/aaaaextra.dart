// // // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// // import 'package:flutter/material.dart';
// // import 'package:mamagram/Logic/UserProfile/loadUserProfile.dart';
// // import 'package:mamagram/UI/homePage/BottomNavbar.dart';

// // class ProfilePage extends StatefulWidget {
// //   static List<Widget> userPostsImagesList = [];
// //   const ProfilePage({super.key});

// //   @override
// //   State<ProfilePage> createState() => _ProfilePageState();
// // }

// // class _ProfilePageState extends State<ProfilePage> {
// //   @override
// //   void initState() {
// //     UserProfile.loadUserData(HomePage.userName);
// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //         child: SizedBox(
// //       width: double.infinity,
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.start,
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.only(left: 20, right: 20),
// //             child: Column(
// //               children: [
// //                 Padding(
// //                   padding: const EdgeInsets.only(top: 20, bottom: 10),
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.end,
// //                     children: [Icon(Icons.menu_sharp, size: 35)],
// //                   ),
// //                 ),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     CircleAvatar(
// //                       radius: 50,
// //                       backgroundColor: Colors.black,
// //                       child: CircleAvatar(
// //                         backgroundImage: UserProfile.userProfilePicShow(),
// //                         radius: 47,
// //                       ),
// //                     ),
// //                     Column(
// //                       children: [
// //                         Text(HomePage.userProfiledata!["posts"].length
// //                             .toString()),
// //                         Text("Posts",
// //                             style: Theme.of(context).textTheme.bodyMedium)
// //                       ],
// //                     ),
// //                     Column(
// //                       children: [
// //                         Text(HomePage.userProfiledata!["followers"].length
// //                             .toString()),
// //                         Text("Followers",
// //                             style: Theme.of(context).textTheme.bodyMedium)
// //                       ],
// //                     ),
// //                     Column(
// //                       children: [
// //                         Text(HomePage.userProfiledata!["following"].length
// //                             .toString()),
// //                         Text("Following",
// //                             style: Theme.of(context).textTheme.bodyMedium)
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //                 SizedBox(height: 20),
// //                 SizedBox(
// //                   width: double.infinity,
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(HomePage.userProfiledata?["userName"],
// //                           style: Theme.of(context).textTheme.bodyMedium),
// //                       Text(HomePage.userProfiledata?["realName"],
// //                           style: Theme.of(context).textTheme.bodySmall),
// //                       Text(HomePage.userProfiledata?["bio"],
// //                           style: Theme.of(context).textTheme.bodySmall),
// //                     ],
// //                   ),
// //                 ),
// //                 SizedBox(height: 20),
// //                 MaterialButton(
// //                   color: Colors.black,
// //                   minWidth: double.infinity,
// //                   onPressed: () {},
// //                   child: Text("Edit Profile"),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           SizedBox(height: 20),
// //           Expanded(
// //             child: CustomScrollView(
// //               primary: false,
// //               slivers: <Widget>[
// //                 SliverPadding(
// //                   padding: const EdgeInsets.all(0),
// //                   sliver: SliverGrid.count(
// //                       crossAxisSpacing: 0,
// //                       mainAxisSpacing: 0,
// //                       crossAxisCount: 3,
// //                       children: ProfilePage.userPostsImagesList),
// //                 ),
// //               ],
// //             ),
// //           )
// //         ],
// //       ),
// //     ));
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:panorama/panorama.dart';

// class Trial extends StatefulWidget {
//   const Trial({super.key});

//   @override
//   State<Trial> createState() => _TrialState();
// }

// class _TrialState extends State<Trial> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Panorama(
//           child: Image.network(
//               "https://st3.depositphotos.com/3724343/12581/i/450/depositphotos_125816544-stock-photo-illustration-seamless-panorama-of-living.jpg")),
//     );
//   }
// }
