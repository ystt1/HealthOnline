import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online/common/bloc/auth/auth_state.dart';
import 'package:health_online/common/bloc/auth/auth_state_cubit.dart';
import 'package:health_online/common/bloc/button/button_state.dart';
import 'package:health_online/common/bloc/button/button_state_cubit.dart';
import 'package:health_online/common/helper/app_navigator.dart';
import 'package:health_online/core/app_colors.dart';
import 'package:health_online/data/auth/models/user_model_createReq.dart';
import 'package:health_online/domain/auth/usecase/sign_up_usecase.dart';
import 'package:health_online/presentation/auth/page/login_page.dart';
import 'package:health_online/presentation/home/page/home_page.dart';

import '../../../core/configs/app_vector.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscurePassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthStateCubit(),
      child: Scaffold(
        body: BlocListener<AuthStateCubit, AuthState>(
          listener: (BuildContext context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đăng kí thành công!'),
                ),
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              );
            }
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                ),
              );
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
                    const SizedBox(height: 30),
                    _hero(),
                    const SizedBox(height: 30),
                    _fullNameField(),
                    const SizedBox(height: 30),
                    _emailField(),
                    const SizedBox(height: 20),
                    _passwordField(),
                    const SizedBox(height: 20),
                    _loginBtn(context),
                    const SizedBox(height: 30),
                    _bottomLink(),
                  ],
                ),
              ),
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
            'Hello Beautiful',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            'Sign Up',
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

  Widget _fullNameField() {
    return TextField(
      controller: fullNameController,
      decoration: const InputDecoration(
        hintText: 'Full Name',
      ),
    );
  }

  Widget _emailField() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      decoration: const InputDecoration(
        hintText: 'Email',
      ),
    );
  }

  Widget _passwordField() {
    return TextField(
      controller: passwordController,
      obscureText: _obscurePassword,
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

  Widget _loginBtn(BuildContext context) {
    return Builder(builder: (context) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
        ),
        onPressed: () {
          context.read<AuthStateCubit>().execute(
              params: UserModelCreateReq(
                  email: emailController.text,
                  password: passwordController.text,
                  fullName: fullNameController.text),
              usecase: SignUpUseCase());
        },
        child: const Text(
          'Sign Up',
          style: TextStyle(color: Colors.white),
        ),
      );
    });
  }

  Widget _bottomLink() {
    return GestureDetector(
      onTap: () {
        AppNavigator.pushReplacement(context, const LoginPage());
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(color: AppColors.primary)),
            TextSpan(
              text: 'Login',
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
