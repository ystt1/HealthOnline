import 'package:dartz/dartz.dart';
import 'package:health_online/data/auth/auth_springboot_service/auth_service_springboot.dart';
import 'package:health_online/data/auth/models/user_model_createReq.dart';
import 'package:health_online/data/auth/models/user_model_loginReq.dart';
import 'package:health_online/domain/auth/repository/auth_repository.dart';

import '../../../service_locator.dart';

class AuthRepositoryImp extends AuthRepository{
  @override
  Future<Either> signUp(UserModelCreateReq user) async {

    return await sl<AuthServiceSpringboot>().signUp(user);
  }

  @override
  Future<Either> login(UserModelLoginReq user) async {
    return await sl<AuthServiceSpringboot>().login(user);
  }
}