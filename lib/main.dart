import 'package:flutter/material.dart';
import 'package:health_online/core/app_theme.dart';
import 'package:health_online/presentation/auth/page/login_page.dart';
import 'package:health_online/presentation/auth/page/sign_up_page.dart';
import 'package:health_online/presentation/booking/page/booking_page.dart';
import 'package:health_online/presentation/booking/page/choose_time_page.dart';
import 'package:health_online/presentation/booking/page/details_doctor_page.dart';
import 'package:health_online/presentation/home/page/home_page.dart';
import 'package:health_online/presentation/profile/page/profile_page.dart';

import 'package:health_online/presentation/splash/page/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.customTheme,
      home: const ChooseTimePage(),
    );
  }
}


