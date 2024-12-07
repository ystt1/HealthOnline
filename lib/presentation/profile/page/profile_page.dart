import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online/common/bloc/button/button_state_cubit.dart';
import 'package:health_online/common/widget/back_and_title.dart';
import 'package:health_online/core/app_colors.dart';
import 'package:health_online/core/configs/app_vector.dart';
import 'package:health_online/core/user_storage.dart';
import 'package:health_online/data/profile/models/update_profile_model_req.dart';
import 'package:health_online/domain/profile/usecase/update_profile_usecase.dart';
import 'package:health_online/presentation/profile/widgets/field_title.dart';
import 'package:health_online/presentation/profile/widgets/modal_bottom_sheet_change_password.dart';

import '../../../common/bloc/button/button_state.dart';

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
  void initState() {
    _userNameController.text = UserStorage.getFullName()!;
    _phoneNumberController.text = UserStorage.getPhoneNumber()!;
    _passwordController.text = "**********";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        height: 188,
        color: AppColors.primary,
      ),
      const BackAndTitle(title: 'Thông tin cá nhân'),
      BlocProvider(
        create: (BuildContext context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (BuildContext context, state) {
            if (state is ButtonSuccessState) {
              UserStorage.setPhoneNumber(_phoneNumberController.text);
              UserStorage.setFullName(_userNameController.text);
              Navigator.of(context, rootNavigator: true).pop();
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Success'),
                  content: const Text('Update Profile Success!'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }

            if (state is ButtonFailureState) {
              Navigator.of(context, rootNavigator: true).pop();
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Error'),
                  content: Text(state.errorMessage),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }

            if (state is ButtonLoadingState) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 117),
                  _avatar(),
                  _changePicture(),
                  const SizedBox(height: 21),
                  const FieldTitle(title: 'FullName'),
                  _userNameField(),
                  const SizedBox(height: 19),
                  const FieldTitle(title: 'Email'),
                  const SizedBox(height: 12),
                  _emailText(),
                  const SizedBox(height: 28),
                  const FieldTitle(title: 'Phone Number'),
                  _phoneField(),
                  const SizedBox(height: 19),
                  const FieldTitle(title: 'Password'),
                  _passwordField(),
                  const SizedBox(height: 74),
                  _changePasswordBtn(context),
                  const SizedBox(height: 10),
                  _updateBtn(context)
                ],
              )),
        ),
      )
    ]));
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
      readOnly: true,
      decoration: const InputDecoration(),
    );
  }

  Widget _emailText() {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 12),
        child: Text(UserStorage.getEmail() ?? ''));
  }

  Widget _changePasswordBtn(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
      ),
      onPressed: () {
        showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(5.0)),
            ),
            context: context,
            builder: (BuildContext context) {
              return const ModalBottomSheetChangePassword();
            });
      },
      child: const Text(
        'Change Password',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }

  Widget _updateBtn(BuildContext context) {
    return Builder(builder: (context) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
        ),
        onPressed: () {
          print(_userNameController.text);
          context.read<ButtonStateCubit>().execute(
              usecase: UpdateProfileUseCase(),
              params: UpdateProfileModelReq(
                  fullName: _userNameController.text,
                  phoneNumber: _phoneNumberController.text));
        },
        child: const Text(
          'Update',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      );
    });
  }
}
