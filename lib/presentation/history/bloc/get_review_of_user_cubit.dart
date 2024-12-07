import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online/domain/history/usecase/get_review_of_user_usecase.dart';
import 'package:health_online/presentation/history/bloc/get_review_of_user_state.dart';

import '../../../service_locator.dart';

class GetReviewOfUserCubit extends Cubit<GetReviewOfUserState> {
  GetReviewOfUserCubit() : super(GetReviewOfUserStateLoading());

  Future<void> onLoading(String idDoctor) async {
    try {
      var response = await sl<GetReviewOfUserUseCase>().call(params: idDoctor);

      response.fold(
          (error) =>
              emit(GetReviewOfUserStateFailure(errorMsg: error.toString())),
          (data) => emit(GetReviewOfUserStateSuccess(starCommentEntity: data)));
    } catch (e) {
      emit(GetReviewOfUserStateFailure(errorMsg: e.toString()));
    }
  }
}
