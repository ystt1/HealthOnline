import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online/domain/booking/usecase/get_list_slot_usecase.dart';
import 'package:health_online/presentation/booking/bloc/choose_date_state.dart';
import '../../../data/booking/models/get_time_slot.dart';
import '../../../service_locator.dart';

class ChooseDateCubit extends Cubit<ChooseDateState> {
  ChooseDateCubit() : super(ChooseDateInitialState());

  Future<void> onGetSlot(GetTimeSlot timeSlot) async {
    emit(ChooseDateLoading());
    try {
      var returnedData = await sl<GetListSlotUseCase>().call(params: timeSlot);
      returnedData.fold((error) {
        emit(ChooseDateLoadFailure(errorMessage: error));
      }, (data) {

        emit(ChooseDateLoadSuccess(choseSlot: data));
      });
    } catch (e) {
      emit(ChooseDateLoadFailure(errorMessage: e.toString()));
    }
  }
}
