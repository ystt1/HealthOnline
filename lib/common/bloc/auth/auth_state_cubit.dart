import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online/common/bloc/auth/auth_state.dart';
import 'package:health_online/common/bloc/auth/user_entity.dart';
import '../../../core/usecase.dart';
import '../../../core/user_storage.dart';

class AuthStateCubit extends Cubit<AuthState> {
  AuthStateCubit() : super(AuthLoading());

  Future<void> execute({dynamic params, required UseCase usecase}) async {
    try {
      Either returnedData = await usecase.call(params: params);

      returnedData.fold((error) {
        emit(AuthFailure(errorMessage: error));
      }, (data) async {
        await UserStorage.setEmail(data.email);
        await UserStorage.setFullName(data.fullName);
        await UserStorage.setIsLogged(true);
        emit(AuthSuccess(user: data));
      });
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> checkLoginStatus() async {
    final isLoggedIn = UserStorage.getIsLogged() ?? false;

    if (isLoggedIn) {
      emit(AuthSuccess(
          user: UserEntity(
              email: UserStorage.getEmail()!,
              password: "",
              fullName: UserStorage.getFullName())));
    } else {
      emit(AuthLoading());
    }
  }

  Future<void> logOut() async {
    UserStorage.setIsLogged(false);
    emit(AuthLoading());
  }
}
