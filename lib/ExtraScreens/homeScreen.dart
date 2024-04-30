import 'package:dotslash/ExtraScreens/category_list/category_list.dart';
import 'package:dotslash/ExtraScreens/trending/trending.dart';
import 'package:dotslash/resources/exploreData/explore_data.dart';
import 'package:dotslash/resources/trendData/trend_data.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'drawer/drawer.dart';
import 'explore_projects/explore_projects.dart';
import '../Widgets/search_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> exploreItems = [];
  List<Widget> trendItems = [];
  ExploreData exploreData = ExploreData();
  TrendingData trendsData = TrendingData();

  bool isLoading = false;

  void fetchData() async {
    setState(() async {
      exploreItems = await exploreData.fetchExploreData(context);
      trendItems = await trendsData.fetchtrendingData(context);
      isLoading = false;
    });
  }

  @override
  void initState() {
    setState(() {
      fetchData();
      isLoading = true;
    });
    super.initState();
  }

  void openCategoryTabsDrawer() {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerScreen(
        openCategoryTabsDrawer: openCategoryTabsDrawer,
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 65,
        centerTitle: true,
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
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_open_rounded,
              size: 32,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.search_rounded,
              color: Colors.black,
              size: 29,
            ),
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15,
              ),
              child: Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        0.3,
                      ),
                      blurRadius: 5,
                      offset: const Offset(
                        0,
                        3,
                      ),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      15,
                    ),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Lottie.asset(
                          'assets/animation/anime.json',
                          width: 600,
                          height: 600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Help is our\nmain goal',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.7,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 95,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.black,
                                ),
                              ),
                              child: const Text(
                                'Donate',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15,
              ),
              child: Text(
                "Explore",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  letterSpacing: 1,
                ),
              ),
            ),
            isLoading
                ? Container(
                    height: 180,
                    child: Center(
                      child: Lottie.asset(
                        'assets/animation/loading.json',
                        width: 50,
                        height: 50,
                        repeat: true,
                      ),
                    ),
                  )
                : ExploreProjects(exploreItems: exploreItems),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 8,
              ),
              child: Text(
                "Categories",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  letterSpacing: 1,
                ),
              ),
            ),
            Categories(),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 18, bottom: 15),
              child: Text(
                "Trending",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  letterSpacing: 0.7,
                ),
              ),
            ),
            Trending(trendingItems: trendItems),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
