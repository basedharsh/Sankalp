// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LinkedInPostCard extends StatefulWidget {
  final String profileImageUrl;
  final String name;
  final String title;
  final String postingTime;
  final String postContent;
  final String? postImageUrl;
  final List<dynamic> likes;
  final String userID;
  final String postID;

  const LinkedInPostCard({
    Key? key,
    required this.profileImageUrl,
    required this.name,
    required this.title,
    required this.postingTime,
    required this.postContent,
    this.postImageUrl,
    required this.likes,
    required this.userID,
    required this.postID,
  }) : super(key: key);

  @override
  _LinkedInPostCardState createState() => _LinkedInPostCardState();
}

class _LinkedInPostCardState extends State<LinkedInPostCard> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  static const int maxAlphavetsVisible = 250;

  @override
  void initState() {
    super.initState();
    if (widget.postContent.length > maxAlphavetsVisible) {
      firstHalf = widget.postContent.substring(0, maxAlphavetsVisible);
      secondHalf = widget.postContent
          .substring(maxAlphavetsVisible, widget.postContent.length);
    } else {
      firstHalf = widget.postContent;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    String currentUserID = FirebaseAuth.instance.currentUser!.uid;
    return Card(
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.profileImageUrl),
            ),
            title: Text(widget.name),
            subtitle: Text('${widget.title} • ${widget.postingTime}'),
            trailing: IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: secondHalf.isEmpty
                ? Text(firstHalf)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(hiddenText
                          ? ('$firstHalf...')
                          : (firstHalf + secondHalf)),
                      InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              hiddenText ? "Read more" : "Read less",
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            hiddenText = !hiddenText;
                          });
                        },
                      ),
                    ],
                  ),
          ),
          // Image display conditionally
          if (widget.postImageUrl != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: Image.network(
                  widget.postImageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ButtonBar(
            children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.thumb_up),
                label: Text(widget.likes.length.toString()),
                onPressed: () {
                  if (widget.userID == currentUserID) {
                    if (kDebugMode) {
                      print("Cannot Like Own Post");
                    }
                  } else {
                    if (widget.likes.contains(currentUserID)) {
                      setState(() {
                        widget.likes.remove(currentUserID);
                      });
                      FirebaseFirestore.instance
                          .collection("posts")
                          .doc(widget.postID)
                          .update({'likes': widget.likes});
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(widget.userID)
                          .update({'karma': FieldValue.increment(-10)});
                      if (kDebugMode) {
                        print("UnLiked");
                      }
                    } else {
                      setState(() {
                        widget.likes.add(currentUserID);
                      });
                      FirebaseFirestore.instance
                          .collection("posts")
                          .doc(widget.postID)
                          .update({'likes': widget.likes});
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(widget.userID)
                          .update({'karma': FieldValue.increment(10)});
                      if (kDebugMode) {
                        print("Liked");
                      }
                    }
                    // setState(() {
                    //   widget.likes.add(FirebaseAuth.instance.currentUser!.uid);
                    // });
                  }
                },
              ),
              TextButton.icon(
                icon: const Icon(Icons.comment),
                label: const Text('Comment'),
                onPressed: () {},
              ),
              TextButton.icon(
                icon: const Icon(Icons.share),
                label: const Text('Share'),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
