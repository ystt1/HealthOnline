import 'package:flutter/material.dart';

class FieldTitle extends StatelessWidget {
  final String title;
  const FieldTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      );

  }
}
