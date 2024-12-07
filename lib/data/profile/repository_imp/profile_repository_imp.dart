import 'package:dartz/dartz.dart';
import 'package:health_online/data/profile/models/change_password_model_req.dart';
import 'package:health_online/data/profile/models/update_profile_model_req.dart';
import 'package:health_online/data/profile/springboot_service/profile_springboot_service.dart';
import 'package:health_online/domain/profile/repository/profile_repository.dart';

import '../../../service_locator.dart';

class ProfileRepositoryImp extends ProfileRepository {
  @override
  Future<Either> changePassword(ChangePasswordModelReq passwords) async {
    try {
      return await sl<ProfileSpringbootService>().changePassword(passwords);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> updateProfile(UpdateProfileModelReq newProfile) async{
    try {
      return await sl<ProfileSpringbootService>().updateProfile(newProfile);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
