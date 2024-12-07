import 'package:dartz/dartz.dart';
import 'package:health_online/core/usecase.dart';
import 'package:health_online/data/profile/models/update_profile_model_req.dart';
import 'package:health_online/domain/profile/repository/profile_repository.dart';

import '../../../service_locator.dart';

class UpdateProfileUseCase implements UseCase<Either, UpdateProfileModelReq> {
  @override
  Future<Either> call({UpdateProfileModelReq? params}) async {
    return await sl<ProfileRepository>().updateProfile(params!);
  }
}
