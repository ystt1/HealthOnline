import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online/core/user_storage.dart';
import 'package:health_online/domain/history/usecase/get_history_usecase.dart';
import 'package:health_online/presentation/history/bloc/get_history_state.dart';

import '../../../service_locator.dart';

class GetHistoryCubit extends Cubit<GetHistoryState> {
  GetHistoryCubit() : super(GetHistoryStateInitial());

  Future<void> getHistory() async {
    emit(GetHistoryStateLoading());
    try {
      var response =
          await sl<GetHistoryUseCase>().call(params: UserStorage.getId());
      response.fold((error) => emit(GetHistoryStateFailure(errorMsg: error)),
          (data) => emit(GetHistoryStateSuccess(histories: data)));
    } catch (e) {
      emit(GetHistoryStateFailure(errorMsg: e.toString()));
    }
  }
}
