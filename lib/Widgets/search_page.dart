import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../ExtraScreens/search/read_project/read_project.dart';
import 'package:string_similarity/string_similarity.dart';

class ItemData {
  final String imageUrl;
  final String title;
  final int reviewCount;
  final String description;
  final String needDescription;

  ItemData({
    required this.imageUrl,
    required this.title,
    required this.reviewCount,
    required this.description,
    required this.needDescription,
  });
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();
  List<dynamic> allUsersData = [];
  List<Widget> searchedUsers = [];
  void loadData() async {
    await firestore.collection('users').get().then((value) {
      setState(() {
        allUsersData = value.docs;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 65,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Volunteer",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 4.0,
                      offset: const Offset(
                        0.9,
                        0.9,
                      ),
                    ),
                  ],
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: searchController,
                    onChanged: (text) {
                      setState(() {
                        searchedUsers = [];
                      });
                      for (int i = 0; i < allUsersData.length; i++) {
                        String name = allUsersData[i].data()["username"];
                        double similarity =
                            name.similarityTo(searchController.text);
                        if (similarity >= 0.3 && searchController.text != "") {
                          setState(() {
                            searchedUsers.add(GestureDetector(
                              onTap: () {},
                              child: Card(
                                elevation: 4.0,
                                margin: EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://placehold.co/600x400/png"),
                                        radius: 30.0,
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        name,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                          });
                        }
                        print(similarity);
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.done,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          print(searchController.text);
                          print(allUsersData);
                          setState(() {
                            searchedUsers = [];
                          });
                          for (int i = 0; i < allUsersData.length; i++) {
                            String name = allUsersData[i].data()["username"];
                            double similarity =
                                name.similarityTo(searchController.text);
                            if (similarity >= 0.3 &&
                                searchController.text != "") {
                              setState(() {
                                searchedUsers.add(Card(
                                  elevation: 4.0,
                                  margin: EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              "https://placehold.co/600x400/png"),
                                          radius: 30.0,
                                        ),
                                        SizedBox(width: 10.0),
                                        Text(
                                          name,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                              });
                            }
                            print(similarity);
                          }
                        },
                      ),
                      hintText: "   Search Users",
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 500,
              child: ListView.builder(
                  itemCount: searchedUsers.length,
                  itemBuilder: (context, index) {
                    return searchedUsers[index];
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
