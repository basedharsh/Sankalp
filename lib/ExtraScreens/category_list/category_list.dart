import 'package:flutter/material.dart';

import 'category_tabs/category_tab.dart';

class Categories extends StatelessWidget {
  Categories({Key? key});

  // Define your categories here
  final List<CategoryData> categories = [
    CategoryData(
      iconAsset: 'assets/icons/all.png',
      name: 'All',
      routeName: '/category_tabs', // Specify the route name for this category
    ),
    CategoryData(
      iconAsset: 'assets/icons/entertainment.png',
      name: 'In-Progress',
      routeName: '/category_tabs', // Specify the route name for this category
    ),
    CategoryData(
      iconAsset: 'assets/icons/peace.png',
      name: 'Hiring',
      routeName: '/category_tabs', // Specify the route name for this category
    ),
    CategoryData(
      iconAsset: 'assets/icons/paw.png',
      name: 'Completed',
      routeName: '/category_tabs', // Specify the route name for this category
    ),
    // CategoryData(
    //   iconAsset: 'assets/icons/sustainable.png',
    //   name: 'Environment',
    //   routeName: '/category_tabs', // Specify the route name for this category
    // ),
    // CategoryData(
    //   iconAsset: 'assets/icons/dumbbell.png',
    //   name: 'Trainer',
    //   routeName: '/category_tabs', // Specify the route name for this category
    // ),
    // CategoryData(
    //   iconAsset: 'assets/icons/chef.png',
    //   name: 'Chef',
    //   routeName: '/category_tabs', // Specify the route name for this category
    // ),
    // Add more categories as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CategoryTabs(selectedCategory: category.name),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              width: 95,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor:
                        Colors.transparent, // Customize the color as needed
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black, // Stroke color
                          width: 2, // Stroke width
                        ),
                      ),
                      child: CircleAvatar(
                        radius:
                            75, // Adjust the radius to make the inner CircleAvatar smaller
                        backgroundColor: Colors.white, // Background color
                        child: Image.asset(
                          category.iconAsset,
                          width: 35, // Customize the icon size
                          height: 35,
                          color: Colors.black, // Customize the icon color
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold // Customize the text size
                        ),
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

class CategoryData {
  final String iconAsset;
  final String name;
  final String routeName; // Add routeName for navigation

  CategoryData({
    required this.iconAsset,
    required this.name,
    required this.routeName,
  });
}
