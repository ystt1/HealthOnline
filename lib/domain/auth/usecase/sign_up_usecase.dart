import 'package:dartz/dartz.dart';
import 'package:health_online/core/usecase.dart';
import 'package:health_online/data/auth/models/user_model_createReq.dart';
import 'package:health_online/domain/auth/repository/auth_repository.dart';

import '../../../service_locator.dart';

class SignUpUseCase implements UseCase<Either,UserModelCreateReq> {
  @override
  Future<Either> call({UserModelCreateReq ? params}) async {

    return await sl<AuthRepository>().signUp(params!);
  }

}