// // ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:mamagram/UI/homePage/BottomNavbar.dart';
// import 'package:mamagram/UI/homePage/explorePage.dart';
// import 'package:mamagram/UI/postClickPage/postClick.dart';
// import 'package:mamagram/UI/searchedUser/searchedProfilePage.dart';
// import 'package:mamagram/routing.dart';
// import 'package:string_similarity/string_similarity.dart';

// class ExplorePageLogic {
//   static Future<void> searchUsers(
//       String searchedName, BuildContext context) async {
//     ExplorePage.searchedUserDisplay = [];
//     final db = FirebaseFirestore.instance;
//     await db.collection("user").get().then((value) async {
//       ExplorePage.searchedUserDisplay = [];
//       for (int i = 0; i < value.docs.length; i++) {
//         double similarity = value.docs[i].id.similarityTo(searchedName);
//         if (similarity >= 0.3 && searchedName != "") {
//           ExplorePage.searchedUserDisplay.add(GestureDetector(
//             onTap: () async {
//               List<dynamic> postIdList = value.docs[i].data()["posts"];
//               List<Map<String, dynamic>?> postDataList = [];
//               for (int i = 0; i < postIdList.length; i++) {
//                 await db
//                     .collection("posts")
//                     .doc(postIdList[i])
//                     .get()
//                     .then((postValue) async {
//                   postDataList.add(postValue.data());
//                 });
//               }

//               SearchedProfilePage.userPostsImagesList = [];
//               for (int i = 0; i < postDataList.length; i++) {
//                 SearchedProfilePage.userPostsImagesList.add(GestureDetector(
//                   onTap: () {
//                     RoutingPage.goToNext(
//                         context: context,
//                         navigateTo: PostClickPage(postData: postDataList[i]));
//                   },
//                   child: Container(
//                       child: Image.network(
//                     postDataList[i]!["pictureLink"],
//                     fit: BoxFit.cover,
//                   )),
//                 ));
//               }
//               SearchedProfilePage.searchedUserData = value.docs[i].data();
//               SearchedProfilePage.searchedUserPosts = postDataList;

//               RoutingPage.goToNext(
//                   context: context, navigateTo: SearchedProfilePage());
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: Container(
//                 height: 80,
//                 width: double.infinity,
//                 child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       CircleAvatar(
//                         radius: 30,
//                         backgroundColor: Colors.black,
//                         child: CircleAvatar(
//                           backgroundImage: NetworkImage(
//                               value.docs[i].data()["profilePicture"]),
//                           radius: 27,
//                         ),
//                       ),
//                       SizedBox(width: 20),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(value.docs[i].data()["userName"],
//                               style: Theme.of(context).textTheme.bodyLarge),
//                           Text(
//                             value.docs[i].data()["realName"],
//                             style: Theme.of(context).textTheme.bodySmall,
//                           ),
//                         ],
//                       )
//                     ]),
//               ),
//             ),
//           ));
//         }
//       }
//     });
//   }

//   static Future<void> followSearchedUser(Map<String, dynamic>? currentUserData,
//       Map<String, dynamic>? searchedUserData) async {
//     final db = FirebaseFirestore.instance;
//     if (currentUserData!["following"].contains(searchedUserData!["userName"])) {
//       currentUserData["following"].remove(searchedUserData["userName"]);
//       searchedUserData["followers"].remove(currentUserData["userName"]);

//       print("Unfollowed");
//     } else {
//       currentUserData["following"].add(searchedUserData["userName"]);
//       searchedUserData["followers"].add(currentUserData["userName"]);
//       print("Followed");
//     }
//     List<dynamic> newFollowingList = currentUserData["following"];
//     List<dynamic> newFollowersList = searchedUserData["followers"];
//     await db
//         .collection("user")
//         .doc(currentUserData["userName"])
//         .update({"following": newFollowingList}).then((value) async {
//       await db
//           .collection("user")
//           .doc(currentUserData["userName"])
//           .get()
//           .then((value) {
//         HomePage.userProfiledata = value.data();
//       });
//     });
//     await db
//         .collection("user")
//         .doc(searchedUserData["userName"])
//         .update({"followers": newFollowersList}).then((value) async {
//       await db
//           .collection("user")
//           .doc(searchedUserData["userName"])
//           .get()
//           .then((value) {
//         SearchedProfilePage.searchedUserData = value.data();
//       });
//     });
//   }
// }
// // 