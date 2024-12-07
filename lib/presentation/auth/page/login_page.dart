import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_online/common/bloc/button/button_state_cubit.dart';
import 'package:health_online/core/app_colors.dart';
import 'package:health_online/core/configs/app_vector.dart';
import 'package:health_online/data/auth/models/user_model_loginReq.dart';
import 'package:health_online/domain/auth/usecase/login_usecase.dart';
import 'package:health_online/presentation/auth/page/sign_up_page.dart';

import '../../../common/bloc/auth/auth_state.dart';
import '../../../common/bloc/auth/auth_state_cubit.dart';
import '../../../common/helper/app_navigator.dart';
import '../../home/page/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return BlocListener<AuthStateCubit, AuthState>(
            listener: (BuildContext context, state) {
              if (state is AuthSuccess) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Đăng nhập thành công')));
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                      (route) => false,
                );
              }
              if (state is AuthFailure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
            },
            child: Container(
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
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(
        hintText: 'Email',
      ),
    );
  }

  Widget _passwordField() {
    return TextField(
      obscureText: _obscurePassword,
      controller: _passwordController,
      decoration: InputDecoration(
        hintText: 'Password',
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
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
    return Builder(
      builder: (BuildContext context) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
          ),
          onPressed: () {
            context.read<AuthStateCubit>().execute(
                params: UserModelLoginReq(
                    email: _emailController.text,
                    password: _passwordController.text),
                usecase: LoginUseCase());
          },
          child: const Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  Widget _bottomLink() {
    return GestureDetector(
      onTap: () => AppNavigator.pushReplacement(context, const SignUpPage()),
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
