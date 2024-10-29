import 'package:flutter/material.dart';
import 'package:health_online/common/widget/back_and_title.dart';
import 'package:health_online/core/app_colors.dart';
import 'package:health_online/core/configs/app_vector.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 188,
            color: AppColors.primary,
          ),
          const BackAndTitle(title: 'Thông tin cá nhân'),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 117),
                _avatar(),
                _changePicture(),
                const SizedBox(height: 21),
                _fieldTitle('Username'),
                _userNameField(),
                const SizedBox(height: 19),
                _fieldTitle('Email'),
                const SizedBox(height: 12),
                _emailText(),
                const SizedBox(height: 28),
                _fieldTitle('Phone Number'),
                _phoneField(),
                const SizedBox(height: 19),
                _fieldTitle('Password'),
                _passwordField(),
                const SizedBox(height: 74),
                _updateBtn()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _avatar() {
    return Container(
      width: 142,
      height: 142,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(AppVector.avatar),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _changePicture() {
    return const Text('Change Picture');
  }

  Widget _fieldTitle(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _userNameField() {
    return TextField(
      controller: _userNameController,
      decoration: const InputDecoration(),
    );
  }

  Widget _phoneField() {
    return TextField(
      controller: _phoneNumberController,
      decoration: const InputDecoration(),
    );
  }

  Widget _passwordField() {
    return TextField(
      controller: _passwordController,
      decoration: const InputDecoration(),
    );
  }

  Widget _emailText() {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 12),
        child: const Text('21521637@gm.uit.edu.vn'));
  }

  Widget _updateBtn() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
      ),
      onPressed: () {},
      child: Text('Update',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
    );
  }
}
