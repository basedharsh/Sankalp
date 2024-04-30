import 'package:dotslash/ExtraScreens/category_list/category_tabs/environment/envo.dart';
import 'package:dotslash/ExtraScreens/drawer/drawer.dart';
import 'package:flutter/material.dart';

import '../../../Widgets/search_page.dart';
import 'all/all.dart';
import 'animal_wellfare/animal.dart';
import 'chef/chef.dart';
import 'entertainment/entmt.dart';
import 'social_impact/social.dart';
import 'trainer/trainers.dart';

class CategoryTabs extends StatefulWidget {
  final String? selectedCategory;

  const CategoryTabs({Key? key, this.selectedCategory}) : super(key: key);

  @override
  State<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  final List<Widget> _tabs = [
    Tab(text: 'All'),
    Tab(text: 'Entertainment'),
    Tab(text: 'Social Impact'),
    Tab(text: 'Animal Wellfare'),
    Tab(text: 'Environment'),
    Tab(text: 'Trainer'),
    Tab(text: 'Chef'),
  ];

  List<String> _tabLabels = [
    'All',
    'Entertainment',
    'Social Impact',
    'Animal Wellfare',
    'Environment',
    'Trainer',
    'Chef',
  ];

  // Function to open the CategoryTabs drawer
  void openCategoryTabsDrawer() {
    Scaffold.of(context).openDrawer();
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      initialIndex: 0, // Set the initial index to 0 (or any other default)
      length: _tabs.length,
      vsync: this,
    );

    if (widget.selectedCategory != null) {
      int initialTabIndex = _tabLabels.indexOf(widget.selectedCategory!);
      if (initialTabIndex != -1) {
        // Only update the initial tab index if the category is found
        _controller.index = initialTabIndex;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        drawer: DrawerScreen(
          openCategoryTabsDrawer: openCategoryTabsDrawer,
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 8,
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: Container(
              height: 48.0,
              child: TabBar(
                controller: _controller,
                tabs: _tabs,
                isScrollable: true,
                indicatorColor: Colors.black, // Set active tab color
                unselectedLabelColor: Colors.grey, // Set inactive tab color
                labelColor: Colors.black, // Set active tab text color
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: const [
            All(),
            EntmtScreen(),
            SocialScreen(),
            Animal(),
            EnvoScreen(),
            Trainer(),
            Chef()
          ],
        ),
      ),
    );
  }
}
