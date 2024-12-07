import 'package:dartz/dartz.dart';
import 'package:health_online/data/profile/models/change_password_model_req.dart';
import 'package:health_online/data/profile/models/update_profile_model_req.dart';

abstract class ProfileRepository{
  Future<Either> changePassword(ChangePasswordModelReq passwords);
  Future<Either> updateProfile(UpdateProfileModelReq newProfile);
}