import 'package:flutter/material.dart';
import 'package:health_online/common/widget/back_and_title.dart';
import 'package:health_online/core/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 188,
            color: AppColors.primary,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BackAndTitle(title: 'Thông tin cá nhân'),
            ],
          )
        ],
      ),
    );
  }
}
