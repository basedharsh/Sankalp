import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../resources/trendData/trend_data.dart';
import 'tread_page/trend_page.dart';

class Trending extends StatefulWidget {
  final List<Widget> trendingItems;
  const Trending({super.key, required this.trendingItems});

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  int index = 0;
  List trendingItems = [];
  int _currentIndex = 0;
  int _currentDotIndex = 0;
  void initState() {
    super.initState();
    fetchTrendData();
  }

  fetchTrendData() async {
    dynamic trend = await TrendingData().fetchtrendingData(context);

    if (trend == null) {
      print('Error fetching trend data');
    } else {
      setState(() {
        trendingItems = trend;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.trendingItems,
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
    // return Container(
    //   height: 200, // Adjust the height as needed
    //   child: ListView(
    //     scrollDirection: Axis.horizontal,
    //     children: [
    //       GestureDetector(
    //         onTap: () {
    //           // Navigator.of(context).push(MaterialPageRoute(
    //           //   builder: (context) => trendsProject,
    //           // ));
    //         },
    //         child: Container(
    //           width: 180, // Adjust the width as needed
    //           margin: const EdgeInsets.symmetric(horizontal: 8),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               // ClipRRect(
    //               //   borderRadius: BorderRadius.circular(8),
    //               //   child: Image.network(
    //               //     trendingItems[index]['project_Image'],
    //               //     width: double.infinity,
    //               //     height: 120,
    //               //     fit: BoxFit.cover,
    //               //   ),
    //               // ),
    //               // const SizedBox(height: 8),
    //               // Text(
    //               //   trendingItems[index]['project_Name'],
    //               //   style: const TextStyle(
    //               //     fontSize: 16,
    //               //     fontWeight: FontWeight.bold,
    //               //   ),
    //               // ),
    //               // const SizedBox(height: 4),
    //               // Text(
    //               //   (trendDetails[trendTexts[index]] != null
    //               //       ? trendDetails[trendTexts[index]]!['trendNeedDes'] ??
    //               //           'No trendDetail found'
    //               //       : 'No trendDetail found'),
    //               //   maxLines: 2,
    //               //   overflow: TextOverflow.ellipsis,
    //               //   style: const TextStyle(
    //               //     fontSize: 12,
    //               //     fontWeight: FontWeight.w300,
    //               //   ),
    //               // ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  List<String> trendImage = [
    'https://images.pexels.com/photos/15291242/pexels-photo-15291242/free-photo-of-smiling-gardener-among-plants.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.unsplash.com/photo-1520607162513-77705c0f0d4a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2069&q=80',
    'https://images.unsplash.com/photo-1609921212029-bb5a28e60960?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2052&q=80',
    'https://images.pexels.com/photos/5029859/pexels-photo-5029859.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',

    // Add more images
  ];
  List<String> trendTexts = [
    'City Gardening',
    'Content Writer',
    'UI/UX Designer',
    'Environmentalism',

    // Add more texts for each card
  ];
  Map<String, Map<String, String>> trendDetails = {
    'City Gardening': {
      'trendImage':
          'https://images.pexels.com/photos/15291242/pexels-photo-15291242/free-photo-of-smiling-gardener-among-plants.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'trendTexts': 'City Gardening',
      'reviews': '44 reviews',
      'trendDescription':
          "Community in Action is actively seeking international volunteers to help teach English to children and adults in Rio de Janeiro. Short-term intensive English classes enable favela residents to prepare for the job market, school exams, and to master areas of specific interest. Our flexible format is perfect for volunteers who have the desire to make a direct impact, but cannot commit for the duration of a full-semester or longer. This program provides an excellent volunteer English teaching opportunity for college students, gap year students, and adults looking to make an immediate difference. No previous English teaching experience needed!",
      'trendNeedDes':
          "Rio de Janeiro attracts thousands of tourists from all around the world all year round. Having the ability to speak English is a valuable skill for individuals living in Rio de Janeiro, as it opens up various opportunities for employment, education, and personal growth. However, many favela residents face barriers to learning English due to limited access to quality language education and resources. This language barrier can significantly hinder their ability to secure stable employment, pursue higher education, and fully engage in the globalized world.",
    },
    'Content Writer': {
      'trendImage':
          'https://images.unsplash.com/photo-1520607162513-77705c0f0d4a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2069&q=80',
      'trendTexts': 'Content Writer',
      'reviews': '54 reviews',
      'trendDescription': """Join Our Team as a Content Writer
We're in search of a skilled Content Writer to enhance our digital presence. As a Content Writer, you'll craft engaging and informative content for diverse platforms like blogs, websites, and social media. Collaborate with our team to brainstorm ideas, research topics, and maintain our brand's voice. Your adaptability across subjects and formats is crucial for producing captivating, audience-centric content.""",
      'trendNeedDes': """What We're Looking For
We need a Content Writer who combines creativity with precision. You should excel in writing, possess strong grammar and style knowledge, and create content that educates, entertains, and engages. Regular research to stay updated on industry trends ensures our content remains relevant and timely. Working closely with our marketing team, you'll help shape content strategies aligned with our goals and audience.

Strong communication, deadline management, and the ability to simplify complex ideas are vital. Familiarity with SEO and keyword optimization is advantageous. If you're passionate about content, adaptable, and eager to contribute to our brand's growth, join our content development team to make a substantial impact.""",
    },

    'UI/UX Designer': {
      'trendImage':
          'https://images.unsplash.com/photo-1609921212029-bb5a28e60960?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2052&q=80',
      'trendTexts': 'UI/UX Designer',
      'reviews': '267 reviews',
      'trendDescription': """Seeking a UI/UX Designer for Innovative Projects
We are on the lookout for a highly skilled and creative UI/UX Designer to join our team of innovators. As a UI/UX Designer, you will play a pivotal role in shaping the user experience and interface of our digital products and platforms. You will collaborate closely with our development and product teams to design intuitive and visually appealing user interfaces that enhance user satisfaction.

In this role, you will be responsible for creating wireframes, prototypes, and high-fidelity designs, ensuring a seamless and delightful user journey. Your ability to understand user needs, conduct user research, and incorporate feedback will be critical to your success. You will also work on optimizing existing designs and continuously improve the overall user experience.

If you are passionate about user-centered design, have a strong portfolio showcasing your design expertise, and thrive in a dynamic and collaborative environment, we invite you to be part of our team. Join us in creating exceptional digital experiences that leave a lasting impact.""",
      'trendNeedDes': """What We're Looking For in a UI/UX Designer
We are in need of a UI/UX Designer who possesses a blend of creativity and usability expertise. Your primary focus will be on designing user interfaces that are not only aesthetically pleasing but also highly functional and user-friendly. Your role will involve working closely with cross-functional teams to translate complex concepts into intuitive and visually appealing designs.

Key skills include proficiency in design tools, wireframing, prototyping, and conducting user research. You should have a deep understanding of user-centered design principles and a passion for staying updated with industry trends. Your ability to gather and incorporate user feedback into your design iterations is crucial.

If you are a problem solver, have an eye for detail, and are dedicated to creating exceptional user experiences, we encourage you to apply. Join our team and contribute to the development of innovative digital products that set new standards in usability and aesthetics.""",
    },
    'Environmentalism': {
      'trendImage':
          'https://images.pexels.com/photos/5029859/pexels-photo-5029859.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'trendTexts': 'Environmentalism',
      'reviews': '77 reviews',
      'trendDescription':
          "Community in Action is actively seeking international volunteers to help teach English to children and adults in Rio de Janeiro. Short-term intensive English classes enable favela residents to prepare for the job market, school exams, and to master areas of specific interest. Our flexible format is perfect for volunteers who have the desire to make a direct impact, but cannot commit for the duration of a full-semester or longer. This program provides an excellent volunteer English teaching opportunity for college students, gap year students, and adults looking to make an immediate difference. No previous English teaching experience needed!",
      'trendNeedDes':
          "Rio de Janeiro attracts thousands of tourists from all around the world all year round. Having the ability to speak English is a valuable skill for individuals living in Rio de Janeiro, as it opens up various opportunities for employment, education, and personal growth. However, many favela residents face barriers to learning English due to limited access to quality language education and resources. This language barrier can significantly hinder their ability to secure stable employment, pursue higher education, and fully engage in the globalized world.",
    },
    // Add more card details as needed
  };
}
