import 'package:flutter/material.dart';

import 'my_project_page/my_project_page.dart';

class MyProjects extends StatefulWidget {
  const MyProjects({super.key});

  @override
  State<MyProjects> createState() => _MyProjectsState();
}

class _MyProjectsState extends State<MyProjects> {
  List<String> projectImage = [
    'https://images.pexels.com/photos/15291242/pexels-photo-15291242/free-photo-of-smiling-gardener-among-plants.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/16465602/pexels-photo-16465602/free-photo-of-saint-bernard-dog-in-shelter.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/6929205/pexels-photo-6929205.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/5029859/pexels-photo-5029859.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',

    // Add more image URLs as needed
  ];
  List<String> projectName = [
    'City Gardening',
    'Dog shelter',
    'Teach English',
    'Environmentalism',

    // Add more texts for each card
  ];
  List<String> projectTime = [
    '5pm - 9pm',
    '3pm - 6pm',
    '9am - 12pm',
    '9am - 6pm',
  ];
  Map<String, Map<String, String>> projectDetails = {
    'City Gardening': {
      'projectImage':
          'https://images.pexels.com/photos/15291242/pexels-photo-15291242/free-photo-of-smiling-gardener-among-plants.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'projectName': 'City Gardening',
      'projectReviews': '37 reviews',
      'projectApplied': 'Applied : 37',
      'projectDate': '11 Nov, 23',
      'projectTime': '5pm - 9pm',
      'projectDescription':
          'Community in Action is actively seeking international volunteers to help teach English to children and adults in Rio de Janeiro. Short-term intensive English classes enable favela residents to prepare for the job market, school exams, and to master areas of specific interest. Our flexible format is perfect for volunteers who have the desire to make a direct impact, but cannot commit for the duration of a full-semester or longer. This program provides an excellent volunteer English teaching opportunity for college students, gap year students, and adults looking to make an immediate difference. No previous English teaching experience needed!',
      'projectNeed':
          'Rio de Janeiro attracts thousands of tourists from all around the world all year round. Having the ability to speak English is a valuable skill for individuals living in Rio de Janeiro, as it opens up various opportunities for employment, education, and personal growth. However, many favela residents face barriers to learning English due to limited access to quality language education and resources. This language barrier can significantly hinder their ability to secure stable employment, pursue higher education, and fully engage in the globalized world.'
    },
    'Dog shelter': {
      'projectImage':
          'https://images.pexels.com/photos/16465602/pexels-photo-16465602/free-photo-of-saint-bernard-dog-in-shelter.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'projectName': 'Dog shelter',
      'projectReviews': '63 reviews',
      'projectApplied': 'Applied : 76',
      'projectDate': '12 Nov, 23',
      'projectTime': '3pm - 6pm',
      'projectDescription':
          'Community in Action is actively seeking international volunteers to help teach English to children and adults in Rio de Janeiro. Short-term intensive English classes enable favela residents to prepare for the job market, school exams, and to master areas of specific interest. Our flexible format is perfect for volunteers who have the desire to make a direct impact, but cannot commit for the duration of a full-semester or longer. This program provides an excellent volunteer English teaching opportunity for college students, gap year students, and adults looking to make an immediate difference. No previous English teaching experience needed!',
      'projectNeed':
          'Rio de Janeiro attracts thousands of tourists from all around the world all year round. Having the ability to speak English is a valuable skill for individuals living in Rio de Janeiro, as it opens up various opportunities for employment, education, and personal growth. However, many favela residents face barriers to learning English due to limited access to quality language education and resources. This language barrier can significantly hinder their ability to secure stable employment, pursue higher education, and fully engage in the globalized world.'
    },
    'Teach English': {
      'projectImage':
          'https://images.pexels.com/photos/6929205/pexels-photo-6929205.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'projectName': 'Teach English',
      'projectReviews': '35 reviews',
      'projectApplied': 'Applied : 21',
      'projectDate': '9 Nov, 23',
      'projectTime': '9am - 12pm',
      'projectDescription':
          'Community in Action is actively seeking international volunteers to help teach English to children and adults in Rio de Janeiro. Short-term intensive English classes enable favela residents to prepare for the job market, school exams, and to master areas of specific interest. Our flexible format is perfect for volunteers who have the desire to make a direct impact, but cannot commit for the duration of a full-semester or longer. This program provides an excellent volunteer English teaching opportunity for college students, gap year students, and adults looking to make an immediate difference. No previous English teaching experience needed!',
      'projectNeed':
          'Rio de Janeiro attracts thousands of tourists from all around the world all year round. Having the ability to speak English is a valuable skill for individuals living in Rio de Janeiro, as it opens up various opportunities for employment, education, and personal growth. However, many favela residents face barriers to learning English due to limited access to quality language education and resources. This language barrier can significantly hinder their ability to secure stable employment, pursue higher education, and fully engage in the globalized world.'
    },
    'Environmentalism': {
      'projectImage':
          'https://images.pexels.com/photos/5029859/pexels-photo-5029859.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'projectName': 'Environmentalism',
      'projectReviews': '54 reviews',
      'projectApplied': 'Applied : 90',
      'projectDate': '19 Nov, 23',
      'projectTime': '9am - 6pm',
      'projectDescription':
          'Community in Action is actively seeking international volunteers to help teach English to children and adults in Rio de Janeiro. Short-term intensive English classes enable favela residents to prepare for the job market, school exams, and to master areas of specific interest. Our flexible format is perfect for volunteers who have the desire to make a direct impact, but cannot commit for the duration of a full-semester or longer. This program provides an excellent volunteer English teaching opportunity for college students, gap year students, and adults looking to make an immediate difference. No previous English teaching experience needed!',
      'projectNeed':
          'Rio de Janeiro attracts thousands of tourists from all around the world all year round. Having the ability to speak English is a valuable skill for individuals living in Rio de Janeiro, as it opens up various opportunities for employment, education, and personal growth. However, many favela residents face barriers to learning English due to limited access to quality language education and resources. This language barrier can significantly hinder their ability to secure stable employment, pursue higher education, and fully engage in the globalized world.'
    },
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 65,
        centerTitle: true,
        title: const Text(
          "My Projects",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            letterSpacing: 1,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: projectName.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to MyProjectPage with project details
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyProjectPage(
                    projectImage: projectImage[index],
                    projectName: projectName[index],
                    projectReviews: projectDetails[projectName[index]]
                            ?['projectReviews'] ??
                        '',
                    projectApplied: projectDetails[projectName[index]]
                            ?['projectApplied'] ??
                        '',
                    projectDate: projectDetails[projectName[index]]
                            ?['projectDate'] ??
                        '',
                    projectTime: projectTime[index],
                    projectDescription: projectDetails[projectName[index]]
                            ?['projectDescription'] ??
                        '',
                    projectNeed: projectDetails[projectName[index]]
                            ?['projectNeed'] ??
                        '',
                  ),
                ),
              );
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: Container(
                width: double.infinity,
                height: 250,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 0.50),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          0,
                          0,
                          0,
                          10,
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(
                                10), // Rounded bottom-left corner
                            topRight: Radius.circular(
                                10), // Rounded bottom-right corner
                          ),
                          child: Image.network(
                            projectImage[index],
                            width: double.infinity,
                            height: 165,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              projectName[index],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/star.png',
                                  color: Colors.black,
                                  width: 14,
                                  height: 14,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  projectDetails[projectName[index]]
                                          ?['projectReviews'] ??
                                      '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Posted on',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  projectDetails[projectName[index]]
                                          ?['projectDate'] ??
                                      '',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    letterSpacing: 1.2,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Time',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  projectTime[index],
                                  style: const TextStyle(
                                    fontSize: 13,
                                    letterSpacing: 1.2,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              projectDetails[projectName[index]]
                                      ?['projectApplied'] ??
                                  '',
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
