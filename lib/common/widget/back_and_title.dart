import 'package:flutter/material.dart';

class BackAndTitle extends StatelessWidget {
  final String title;

  const BackAndTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const IconButton(
          onPressed: null,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
