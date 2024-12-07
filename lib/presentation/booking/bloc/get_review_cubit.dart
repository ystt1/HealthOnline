import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online/domain/booking/usecase/get_review_usecase.dart';
import 'package:health_online/presentation/booking/bloc/get_review_state.dart';

import '../../../service_locator.dart';

class GetReviewCubit extends Cubit<GetReviewState> {
  GetReviewCubit() : super(GetReviewStateInitial());

  Future<void> getReview(String idDoctor) async {
    try {
      emit(GetReviewStateLoading());
      var response = await sl<GetReviewUseCase>().call(params: idDoctor);

      response.fold((error) => emit(GetReviewStateFailure(errorMsg: error)),
          (reviews) => emit(GetReviewStateSuccess(reviews: reviews)));
    } catch (e) {

      emit(GetReviewStateFailure(errorMsg: e.toString()));
    }
  }
}
