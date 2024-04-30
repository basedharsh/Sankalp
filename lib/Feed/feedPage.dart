// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotslash/Feed/feedCardWid.dart';
import 'package:dotslash/Feed/feedUpload.dart';
import 'package:dotslash/colorScheme.dart';
import 'package:dotslash/volunteerScreen/VolWid/volDrawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

// String newProjectName = '';
// String newProjectImageUrl = '';
// String newProjectTime = '';
// String newProjectDescription = '';
// String newProjectNeed = '';

// String postTitle = '';
// String postDescription = '';
// String postImage = '';
// String postTime = '';

class _FeedPageState extends State<FeedPage> {
  List<Map<String, dynamic>> posts = []; // To store fetched projects
  var userData;

  @override
  void initState() {
    super.initState();
    _fetchProjects();
  }

  Future<void> _fetchProjects() async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection('posts').get();
      List<Map<String, dynamic>> tempPosts = [];

      for (var doc in querySnapshot.docs) {
        var data = doc.data();
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(data['userID'] as String)
            .get();

        // Cast the user document data explicitly
        Map<String, dynamic>? userData =
            userDoc.data() as Map<String, dynamic>?;

        String username = 'Anonymous'; // Default username
        if (userData != null) {
          username = userData['username'] as String? ?? 'Anonymous';
        }

        Map<String, dynamic> post = {
          'postDescription': data['postDescription'] ?? '',
          'postTitle': data['postTitle'] ?? '',
          'postImage': data['postImage'] ?? '',
          'postTime': data['postTime'] ?? '',
          'likes': data['likes'] ?? [],
          'userID': data['userID'] ?? '',
          'postID': doc.id,
          'username': username, // Username fetched for each post
        };

        tempPosts.add(post);
      }

      setState(() {
        posts = tempPosts;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching posts: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.BackgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyle.HighlightColor,
        title: Text('Sankalp', style: TextStyle(color: AppStyle.TextColor1)),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: AppStyle.TextColor1,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  //Image For Ngo
                  backgroundImage: Image.asset(
                    "assets/logo/defaultprofilepic.png",
                  ).image,
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: VolDrawer(),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          var post = posts[index];
          return LinkedInPostCard(
            name: post['username'],
            title: post["postTitle"],
            profileImageUrl: post['postImage'],
            postContent: post['postDescription'],
            // 'Heyy Guys i am excited to announce About Our Project Sankalp. Which Is made with core belief of Helping Needy People.Heyy Guys i am excited to announce About Our Project Sankalp. Which Is made with core belief of Helping Needy People.Heyy Guys i am excited to announce About Our Project Sankalp. Which Is made with core belief of Helping Needy People.',
            postingTime: 'Sankalp',
            postImageUrl: post['postImage'],
            likes: post['likes'],
            userID: post['userID'],
            postID: post['postID'],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        clipBehavior: Clip.antiAlias,
        shape: const CircleBorder(),
        backgroundColor: Colors.black,
        onPressed: () {
          // _showAddProjectModal(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UploadFeed(),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
