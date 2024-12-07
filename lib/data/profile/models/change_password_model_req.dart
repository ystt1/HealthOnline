import 'package:health_online/core/user_storage.dart';

class ChangePasswordModelReq{
  final String? id=UserStorage.getId();
  final String oldPassword;
  final String newPassword;

  ChangePasswordModelReq({required this.oldPassword, required this.newPassword});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'oldPassword': this.oldPassword,
      'newPassword': this.newPassword,
    };
  }


}