import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online/core/app_colors.dart';
import 'package:health_online/presentation/auth/page/sign_up_page.dart';import '../../../common/bloc/auth/auth_state.dart';
import '../../../common/bloc/auth/auth_state_cubit.dart';


import '../../../common/helper/app_navigator.dart';
import '../../auth/page/login_page.dart';
import '../../home/page/home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthStateCubit, AuthState>(
        builder: (BuildContext context, AuthState state) {
          if (state is AuthSuccess) {

            return const HomePage();
          } else {

            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 74),
                  _titleLines(),
                  const SizedBox(height: 50),
                  _hero(),
                  const Spacer(),
                  _signUpBtn(context),
                  const SizedBox(height: 20),
                  _loginBtn(context),
                  const SizedBox(height: 30),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _titleLines() {
    return const SizedBox(
      height: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            'Health Online',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _hero() {
    return Image.asset('assets/vectors/hero.png');
  }

  Widget _signUpBtn(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
      ),
      onPressed: () {
        AppNavigator.push(context, const SignUpPage());
      },
      child: const Text(
        'Sign Up',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _loginBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        AppNavigator.push(context, const LoginPage());
      },
      child: const Text(
        'Login',
      ),
    );
  }
}
