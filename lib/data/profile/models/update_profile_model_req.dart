import 'package:health_online/core/user_storage.dart';

class UpdateProfileModelReq
{
  final String? id=UserStorage.getId();
  final String fullName;
  final String phoneNumber;

  UpdateProfileModelReq({required this.fullName, required this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'fullName': this.fullName,
      'phoneNumber': this.phoneNumber,
    };
  }

}