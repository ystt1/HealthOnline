import 'package:dartz/dartz.dart';
import 'package:health_online/core/usecase.dart';
import 'package:health_online/data/auth/models/user_model_loginReq.dart';
import 'package:health_online/domain/auth/repository/auth_repository.dart';

import '../../../service_locator.dart';

class LoginUseCase implements UseCase<Either,UserModelLoginReq> {
  @override
  Future<Either> call({UserModelLoginReq? params})async{
    return await sl<AuthRepository>().login(params!);
  }

}