import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online/common/bloc/auth/auth_state.dart';
import 'package:health_online/common/bloc/auth/auth_state_cubit.dart';
import 'package:health_online/core/app_theme.dart';
import 'package:health_online/core/user_storage.dart';
import 'package:health_online/presentation/home/page/home_page.dart';
import 'package:health_online/presentation/splash/page/splash_page.dart';
import 'package:health_online/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await UserStorage.init();
  final authCubit = AuthStateCubit();
  await authCubit.checkLoginStatus();
  runApp(
    BlocProvider(
      create: (context) => authCubit,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: AppTheme.customTheme,
        home: BlocBuilder<AuthStateCubit, AuthState>(
            builder: (BuildContext context, AuthState state) {
          if (state is AuthSuccess) {
            return HomePage();
          }
          return SplashPage();
        }));
  }
}
