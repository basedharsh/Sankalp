import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ExploreProjects extends StatefulWidget {
  final List<Widget> exploreItems;
  const ExploreProjects({super.key, required this.exploreItems});

  @override
  State<ExploreProjects> createState() => _ExploreProjectsState();
}

class _ExploreProjectsState extends State<ExploreProjects> {
  //pisdflkh
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.exploreItems,
          options: CarouselOptions(
            height: 220,
            initialPage: _currentIndex,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
                _currentDotIndex = index % 5;
              });
            },
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2),
            autoPlayAnimationDuration: const Duration(milliseconds: 900),
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 6,
              height: 6,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentDotIndex == index ? Colors.black : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }

  int _currentIndex = 0;
  int _currentDotIndex = 0;
  List<String> imageUrls = [
    'https://images.pexels.com/photos/6325984/pexels-photo-6325984.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/1728163/pexels-photo-1728163.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/16465602/pexels-photo-16465602/free-photo-of-saint-bernard-dog-in-shelter.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/4058411/pexels-photo-4058411.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/3437689/pexels-photo-3437689.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=',

    // Add more image URLs as needed
  ];
  List<String> cardTexts = [
    'Teach English',
    'Photographer',
    'Dog Shelter',
    'Gym Trainer',
    'Personal Chef',
    'review'
    // Add more texts for each card
  ];
  List<String> projectTime = [
    '5pm - 9pm',
    '3pm - 6pm',
    '9am - 12pm',
    '9am - 6pm',
    '2pm - 6pm',
  ];
}
