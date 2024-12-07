import 'package:dartz/dartz.dart';
import 'package:health_online/data/auth/models/user_model_createReq.dart';

import '../../../data/auth/models/user_model_loginReq.dart';

abstract class AuthRepository{
  Future<Either> signUp(UserModelCreateReq user);
  Future<Either> login(UserModelLoginReq user);
}