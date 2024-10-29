import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_online/core/app_colors.dart';
import 'package:health_online/core/configs/app_vector.dart';
import 'package:health_online/presentation/auth/page/sign_up_page.dart';

import '../../../common/helper/app_navigator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 74),
                _titleLines(),
                const SizedBox(height: 60),
                _hero(),
                const SizedBox(height: 60),
                _emailField(),
                const SizedBox(height: 20),
                _passwordField(),
                const SizedBox(height: 20),
                _loginBtn(),
                const SizedBox(height: 30),
                _bottomLink(),
              ],
            ),
          ),
        ),
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
            'Welcome back',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            'Login',
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
    return Image.asset(
      'assets/vectors/hero.png',
      width: 327,
      height: 280,
    );
  }

  Widget _emailField() {
    return const TextField(
      decoration: InputDecoration(
        hintText: 'Email',
      ),
    );
  }

  Widget _passwordField() {
    return TextField(
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        hintText: 'Password',
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscurePassword=!_obscurePassword;
            });
          },
          icon: Image.asset(
            _obscurePassword
                ? AppVector.showPasswordIcon
                : AppVector.hidePasswordIcon,
            height: 20,
          ),
        ),
      ),
    );
  }

  Widget _loginBtn() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
      ),
      onPressed: () {},
      child: const Text(
        'Login',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _bottomLink() {
    return GestureDetector(
      onTap: ()=> AppNavigator.pushReplacement(context, const SignUpPage()),
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
                text: 'Dont\'t have an account? ',
                style: TextStyle(color: AppColors.primary)),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
