import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online/common/bloc/button/button_state.dart';
import 'package:health_online/common/bloc/button/button_state_cubit.dart';
import 'package:health_online/data/profile/models/change_password_model_req.dart';
import 'package:health_online/domain/profile/usecase/change_password_usecase.dart';
import 'package:health_online/presentation/profile/widgets/field_title.dart';

import '../../../core/app_colors.dart';

class ModalBottomSheetChangePassword extends StatefulWidget {
  const ModalBottomSheetChangePassword({super.key});

  @override
  State<ModalBottomSheetChangePassword> createState() =>
      _ModalBottomSheetChangePasswordState();
}

class _ModalBottomSheetChangePasswordState
    extends State<ModalBottomSheetChangePassword> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ButtonStateCubit(),
      child: BlocListener<ButtonStateCubit, ButtonState>(
        listener: (BuildContext context, state) {
          if (state is ButtonSuccessState) {
            Navigator.of(context, rootNavigator: true).pop();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Success'),
                content: const Text('Change Password successful!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Đóng Dialog
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
                      Navigator.of(context).pop(); // Đóng Dialog
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }

          if (state is ButtonLoadingState) {
            showDialog(
              barrierDismissible: false, // Không cho phép đóng khi nhấn ra ngoài
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(), // Hiển thị loading ở giữa
              ),
            );
          }
        },
        child: Container(
            height: 400,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.zero,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const FieldTitle(
                  title: 'Old Password',
                ),
                _oldPasswordField(),
                const FieldTitle(
                  title: 'New Password',
                ),
                _newPasswordField(),
                const FieldTitle(
                  title: 'Re Password',
                ),
                _rePasswordField(),
                _updateBtn(context)
              ],
            )),
      ),
    );
  }

  Widget _oldPasswordField() {
    return TextField(
      controller: _oldPasswordController,
      decoration: const InputDecoration(),
    );
  }

  Widget _newPasswordField() {
    return TextField(
      controller: _newPasswordController,
      decoration: const InputDecoration(),
    );
  }

  Widget _rePasswordField() {
    return TextField(
      controller: _rePasswordController,
      decoration: const InputDecoration(),
    );
  }

  Widget _updateBtn(BuildContext context) {
    return Builder(builder: (context) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
        ),
        onPressed: () {
          if (_rePasswordController.text == _newPasswordController.text) {
            print('press');
            context.read<ButtonStateCubit>().execute(
                usecase: ChangePasswordUseCase(),
                params: ChangePasswordModelReq(
                    oldPassword: _oldPasswordController.text,
                    newPassword: _newPasswordController.text));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('2 mật khẩu mới không giống nhau')));
          }
        },
        child: const Text(
          'Change Password',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      );
    });
  }
}
