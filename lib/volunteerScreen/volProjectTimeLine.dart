// ignore_for_file: file_names

import 'package:dotslash/volunteerScreen/VolWid/TimelineWid.dart';
import 'package:flutter/material.dart';

class VolTimeLine extends StatefulWidget {
  const VolTimeLine({super.key});

  @override
  State<VolTimeLine> createState() => _VolTimeLineState();
}

class _VolTimeLineState extends State<VolTimeLine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            //timeline start
            MyTimeLineWid(
              isFirst: true,
              isLast: false,
              isPast: true,
              endChildCard: Text("Project Assigned"),
            ),
            //mid timeline
            MyTimeLineWid(
              isFirst: false,
              isLast: false,
              isPast: true,
              endChildCard: Text("Project Started"),
            ),
            //end Timeline
            MyTimeLineWid(
              isFirst: false,
              isLast: false,
              isPast: true,
              endChildCard: Text("Project Completed"),
            ),
            MyTimeLineWid(
              isFirst: false,
              isLast: false,
              isPast: true,
              endChildCard: Text("Project Started"),
            ),
            MyTimeLineWid(
              isFirst: false,
              isLast: false,
              isPast: true,
              endChildCard: Text("Project Started"),
            ),
            MyTimeLineWid(
              isFirst: false,
              isLast: false,
              isPast: false,
              endChildCard: Text("Project Started"),
            ),
            MyTimeLineWid(
              isFirst: false,
              isLast: false,
              isPast: false,
              endChildCard: Text("Project Started"),
            ),
            MyTimeLineWid(
              isFirst: false,
              isLast: true,
              isPast: false,
              endChildCard: Text("Project Started"),
            ),
          ],
        ),
      ),
    );
  }
}
