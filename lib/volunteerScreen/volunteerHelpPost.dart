import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VolunteerHelpPosts extends StatefulWidget {
  const VolunteerHelpPosts({super.key});

  @override
  State<VolunteerHelpPosts> createState() => _VolunteerHelpPostsState();
}

class _VolunteerHelpPostsState extends State<VolunteerHelpPosts> {
  List<dynamic> helpData = [];
  bool loading = false;
  String userId = "user123"; // Replace with actual user ID

  void loadData() async {
    setState(() => loading = true);
    try {
      var collection = FirebaseFirestore.instance.collection("help");
      var snapshot = await collection.get();
      setState(() => helpData = snapshot.docs);
    } catch (e) {
      // Handle errors here
    }
    setState(() => loading = false);
  }

  void toggleLike(String postId, List<dynamic> currentLikes) async {
    var collection = FirebaseFirestore.instance.collection("help");
    if (currentLikes.contains(userId)) {
      currentLikes.remove(userId);
    } else {
      currentLikes.add(userId);
    }
    await collection.doc(postId).update({"likes": currentLikes});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Volunteer Help Posts')),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : helpData.isEmpty
              ? Center(child: Text("No posts available"))
              : ListView.builder(
                  itemCount: helpData.length,
                  itemBuilder: (context, index) {
                    var data = helpData[index].data();
                    var postId = helpData[index].id;
                    var likes = data['likes'] ?? [];
                    bool isLiked = likes.contains(userId);
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(data['title'],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                            Text(data['description']),
                            SizedBox(height: 10),
                            Image.network(data['image'], fit: BoxFit.cover),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(isLiked
                                      ? Icons.thumb_up
                                      : Icons.thumb_up_alt_outlined),
                                  onPressed: () => toggleLike(postId, likes),
                                ),
                                Text('Likes: ${likes.length}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
