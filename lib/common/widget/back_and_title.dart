import 'package:flutter/material.dart';

class BackAndTitle extends StatelessWidget {
  final String title;

  const BackAndTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: double.infinity,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
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
      ),
    );
  }
}
