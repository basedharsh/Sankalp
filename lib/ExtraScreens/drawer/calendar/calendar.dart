import 'package:dotslash/ExtraScreens/drawer/calendar/calendar_project/calender_project.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../Widgets/search_page.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  ///////////////////////////////////////////////////////////
  List<Event> getEventMarkers(DateTime day) {
    int count = 0;
    List<Event> events = [];
    final formattedDay = DateTime(day.year, day.month, day.day);

    for (int i = 0; i < projectCName.length; i++) {
      projectCDetails.forEach((key, value) {
        if (key == projectCName[i]) {
          if (projectCDetails[projectCName[i]]?['projectDate'] ==
              formattedDay.toString().substring(0, 10)) {
            count++;
          }
        }
      });
    }
    // final events = _events[formattedDay];
    if (count > 0) {
      for (int i = 0; i < count; i++) {
        events.add(Event(eventName: '', eventDate: '', eventTime: ''));
      }
      return events;
    }
    return [];
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _today = DateTime.now(); // Store the selected date here
  // Map<DateTime, List<Widget>> _events = {};

  List<String> projectCImage = [
    'https://plus.unsplash.com/premium_photo-1661490789477-7d2ee4253e11?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1032&q=80',
    'https://images.unsplash.com/photo-1491438590914-bc09fcaaf77a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
    'https://images.unsplash.com/photo-1531482615713-2afd69097998?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
    'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
  ];

  List<String> projectCName = [
    'Technology and IT Support',
    'Community Cleanup',
    'Education and Training',
    'Research and Data Analysis',
    // Add more texts for each card
  ];
  List<String> projectCTime = [
    '12pm - 6pm',
    '9am - 12pm',
    '9am - 12pm',
    '9am - 6pm',
  ];
  Map<String, Map<String, String>> projectCDetails = {
    'Technology and IT Support': {
      'projectImage':
          'https://images.pexels.com/photos/15291242/pexels-photo-15291242/free-photo-of-smiling-gardener-among-plants.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'projectName': 'Technology and IT Support',
      'projectReviews': '37 reviews',
      'projectApplied': 'Applied : 37',
      'projectDate': '2023-11-10',
      'projectTime': '12pm - 6pm',
      'projectDescription':
          'Community in Action is actively seeking international volunteers to help teach English to children and adults in Rio de Janeiro. Short-term intensive English classes enable favela residents to prepare for the job market, school exams, and to master areas of specific interest. Our flexible format is perfect for volunteers who have the desire to make a direct impact, but cannot commit for the duration of a full-semester or longer. This program provides an excellent volunteer English teaching opportunity for college students, gap year students, and adults looking to make an immediate difference. No previous English teaching experience needed!',
      'projectNeed':
          'Rio de Janeiro attracts thousands of tourists from all around the world all year round. Having the ability to speak English is a valuable skill for individuals living in Rio de Janeiro, as it opens up various opportunities for employment, education, and personal growth. However, many favela residents face barriers to learning English due to limited access to quality language education and resources. This language barrier can significantly hinder their ability to secure stable employment, pursue higher education, and fully engage in the globalized world.'
    },
    'Community Cleanup': {
      'projectImage':
          'https://images.pexels.com/photos/16465602/pexels-photo-16465602/free-photo-of-saint-bernard-dog-in-shelter.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'projectName': 'Community Cleanup',
      'projectReviews': '63 reviews',
      'projectApplied': 'Applied : 76',
      'projectDate': '2023-11-10',
      'projectTime': '9am - 12pm',
      'projectDescription':
          'Community in Action is actively seeking international volunteers to help teach English to children and adults in Rio de Janeiro. Short-term intensive English classes enable favela residents to prepare for the job market, school exams, and to master areas of specific interest. Our flexible format is perfect for volunteers who have the desire to make a direct impact, but cannot commit for the duration of a full-semester or longer. This program provides an excellent volunteer English teaching opportunity for college students, gap year students, and adults looking to make an immediate difference. No previous English teaching experience needed!',
      'projectNeed':
          'Rio de Janeiro attracts thousands of tourists from all around the world all year round. Having the ability to speak English is a valuable skill for individuals living in Rio de Janeiro, as it opens up various opportunities for employment, education, and personal growth. However, many favela residents face barriers to learning English due to limited access to quality language education and resources. This language barrier can significantly hinder their ability to secure stable employment, pursue higher education, and fully engage in the globalized world.'
    },
    'Education and Training': {
      'projectImage':
          'https://images.pexels.com/photos/6929205/pexels-photo-6929205.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'projectName': 'Education and Training',
      'projectReviews': '35 reviews',
      'projectApplied': 'Applied : 21',
      'projectDate': '2023-12-26',
      'projectTime': '3pm - 8pm',
      'projectDescription':
          'Community in Action is actively seeking international volunteers to help teach English to children and adults in Rio de Janeiro. Short-term intensive English classes enable favela residents to prepare for the job market, school exams, and to master areas of specific interest. Our flexible format is perfect for volunteers who have the desire to make a direct impact, but cannot commit for the duration of a full-semester or longer. This program provides an excellent volunteer English teaching opportunity for college students, gap year students, and adults looking to make an immediate difference. No previous English teaching experience needed!',
      'projectNeed':
          'Rio de Janeiro attracts thousands of tourists from all around the world all year round. Having the ability to speak English is a valuable skill for individuals living in Rio de Janeiro, as it opens up various opportunities for employment, education, and personal growth. However, many favela residents face barriers to learning English due to limited access to quality language education and resources. This language barrier can significantly hinder their ability to secure stable employment, pursue higher education, and fully engage in the globalized world.'
    },
    'Research and Data Analysis': {
      'projectImage':
          'https://images.pexels.com/photos/5029859/pexels-photo-5029859.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'projectName': 'Research and Data Analysis',
      'projectReviews': '54 reviews',
      'projectApplied': 'Applied : 90',
      'projectDate': '2024-01-14',
      'projectTime': '11am - 2pm',
      'projectDescription':
          'Community in Action is actively seeking international volunteers to help teach English to children and adults in Rio de Janeiro. Short-term intensive English classes enable favela residents to prepare for the job market, school exams, and to master areas of specific interest. Our flexible format is perfect for volunteers who have the desire to make a direct impact, but cannot commit for the duration of a full-semester or longer. This program provides an excellent volunteer English teaching opportunity for college students, gap year students, and adults looking to make an immediate difference. No previous English teaching experience needed!',
      'projectNeed':
          'Rio de Janeiro attracts thousands of tourists from all around the world all year round. Having the ability to speak English is a valuable skill for individuals living in Rio de Janeiro, as it opens up various opportunities for employment, education, and personal growth. However, many favela residents face barriers to learning English due to limited access to quality language education and resources. This language barrier can significantly hinder their ability to secure stable employment, pursue higher education, and fully engage in the globalized world.'
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 65,
        centerTitle: true,
        title: const Text(
          "Calendar",
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
      ),
      body: Column(
        children: [
          Center(
            child: TableCalendar(
              calendarFormat: _calendarFormat,
              focusedDay: _focusedDay,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, _today),
              firstDay: DateTime.utc(2020, 20, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amberAccent,
                ),
                todayDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              ),
              startingDayOfWeek: StartingDayOfWeek.sunday,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                  _today = selectedDay;
                  print(selectedDay);
                });
              },
              eventLoader: (day) =>
                  getEventMarkers(day), // Use the updated function
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  if (events.isNotEmpty) {
                    int eventCount = events.length;
                    return Stack(
                      children: [
                        Positioned(
                          left: 2,
                          top: 5,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            child: Center(
                              child: Text(
                                eventCount.toString(),
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return null;
                },
              ),
            ),
          ),
          // Center(
          //   child: TableCalendar(
          //     calendarFormat: _calendarFormat,
          //     focusedDay: _focusedDay,
          //     headerStyle: const HeaderStyle(
          //       formatButtonVisible: false,
          //       titleCentered: true,
          //     ),
          //     availableGestures: AvailableGestures.all,
          //     selectedDayPredicate: (day) => isSameDay(day, _today),
          //     firstDay: DateTime.utc(2020, 20, 16),
          //     lastDay: DateTime.utc(2030, 3, 14),
          //     calendarStyle: const CalendarStyle(
          //       selectedDecoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Colors.amberAccent,
          //       ),
          //       todayDecoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Colors.black,
          //       ),
          //     ),
          //     startingDayOfWeek: StartingDayOfWeek.sunday,
          //     onFormatChanged: (format) {
          //       setState(() {
          //         _calendarFormat = format;
          //       });
          //     },
          //     onDaySelected: (selectedDay, focusedDay) {
          //       setState(() {
          //         _focusedDay = focusedDay;
          //         _today = selectedDay; // Set the displayed date
          //       });
          //     },
          //     eventLoader: (day) => getEventMarkers(day),
          //     // eventLoader: (day) {
          //     //   // Convert the day to have the same format as the keys in _events
          //     //   final formattedDay = DateTime(day.year, day.month, day.day);
          //     //   print(day);

          //     //   return _events[formattedDay] ?? [];
          //     // },
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: projectCName.length,
              itemBuilder: (context, index) {
                print(
                    "Randh   :  ${projectCDetails[projectCName[index]]?['projectDate']}");
                print(_today);
                if (_today.toString().substring(0, 10) ==
                    projectCDetails[projectCName[index]]?['projectDate']) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CalendarProject(
                            projectCImage: projectCImage[index],
                            projectCName: projectCName[index],
                            projectCReviews:
                                projectCDetails[projectCName[index]]
                                        ?['projectReviews'] ??
                                    '',
                            projectCApplied:
                                projectCDetails[projectCName[index]]
                                        ?['projectApplied'] ??
                                    '',
                            projectCDate: projectCDetails[projectCName[index]]
                                    ?['projectDate'] ??
                                '',
                            projectCTime: projectCTime[index],
                            projectCDescription:
                                projectCDetails[projectCName[index]]
                                        ?['projectDescription'] ??
                                    '',
                            projectCNeed: projectCDetails[projectCName[index]]
                                    ?['projectNeed'] ??
                                '',
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 10.0,
                        left: 10,
                        top: 5,
                        bottom: 5,
                      ),
                      child: Container(
                        // This is the event container
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          color: Colors.transparent,
                        ),
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 0,
                          top: 15,
                          bottom: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Text(
                                    projectCName[
                                        index], // This is the event's name
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                Text(
                                  projectCDetails[projectCName[index]]
                                          ?['projectDate'] ??
                                      '',

                                  // This is the event's date
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              projectCTime[index],
                              // '$eventStart - $eventEnd', // This is the event's time
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.chevron_right_rounded,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox(
                    height: 0,
                    width: 0,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Event {
  final String eventName;
  final String eventDate;
  final String eventTime;

  Event({
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
  });
}
