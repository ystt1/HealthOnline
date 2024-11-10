import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

class DayCard extends StatefulWidget {
  final bool isChoose;
  final DateTime date;
  const DayCard({super.key, required this.isChoose, required this.date});

  @override
  State<DayCard> createState() => _DayCardState();
}

class _DayCardState extends State<DayCard> {
  final List<String> dayInWeek = [
    'MON',
    'TUE',
    'WED',
    'THUR',
    'FRI',
    'SAT',
    'SUN'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: widget.isChoose ? AppColors.colorChoose : Colors.white,
          border: Border.all(
              color: const Color(0xff6B779A).withOpacity(0.1), width: 1)),
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
           widget.date.day.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: widget.isChoose ? Colors.white : Colors.grey,
            ),
          ),
          Text(
            dayInWeek[widget.date.weekday - 1],
            style: TextStyle(
              fontSize: 10,
              color: widget.isChoose ? Colors.white : Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
