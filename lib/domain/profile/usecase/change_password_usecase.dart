import 'package:dartz/dartz.dart';
import 'package:health_online/core/usecase.dart';
import 'package:health_online/data/profile/models/change_password_model_req.dart';
import 'package:health_online/domain/profile/repository/profile_repository.dart';

import '../../../service_locator.dart';

class ChangePasswordUseCase implements UseCase<Either,ChangePasswordModelReq> {
  @override
  Future<Either> call({ChangePasswordModelReq? params}) async {

    return await sl<ProfileRepository>().changePassword(params!);
  }

}