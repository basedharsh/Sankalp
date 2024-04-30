import 'package:dotslash/volunteerScreen/VolWid/EventCard.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimeLineWid extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final endChildCard;
  const MyTimeLineWid(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.endChildCard,
      required this.isPast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        //Line Style
        beforeLineStyle: LineStyle(
          color: isPast ? Colors.cyan : Colors.cyan.shade100,
          thickness: 5,
        ),
        //The Circle Style
        indicatorStyle: IndicatorStyle(
            color: isPast ? Colors.cyan : Colors.cyan.shade100,
            width: 50,
            iconStyle: IconStyle(
                iconData: Icons.check,
                color: isPast ? Colors.white : Colors.cyan.shade100)),

        //End element
        endChild: TimeLineCard(
          isPast: isPast,
          child: endChildCard,
        ),
      ),
    );
  }
}
