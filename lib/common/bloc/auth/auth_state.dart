import 'package:health_online/common/bloc/auth/user_entity.dart';

abstract class AuthState{}

class AuthSuccess extends AuthState{
  final UserEntity user;

  AuthSuccess({required this.user});
}

class AuthLoading extends AuthState{}

class AuthFailure extends AuthState{
  final String errorMessage;

  AuthFailure({required this.errorMessage});
}