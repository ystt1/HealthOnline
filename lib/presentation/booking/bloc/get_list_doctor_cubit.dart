import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online/data/booking/models/get_time_slot.dart';
import 'package:health_online/domain/booking/usecase/get_list_doctor_usecase.dart';
import 'package:health_online/presentation/booking/bloc/choose_date_cubit.dart';

import '../../../service_locator.dart';
import 'get_list_doctor_state.dart';

class GetListDoctorCubit extends Cubit<GetListDoctorState> {
  GetListDoctorCubit() : super(GetListDoctorInitial());

  void getList(String name) async {
    emit(GetListDoctorLoading());
    try {
      var response = await sl<GetListDoctorUseCase>().call(params: name);
      response.fold(
        (error) => emit(GetListDoctorFailure()),
        (data) => emit(
          GetListDoctorSuccess(doctors: data),
        ),
      );
    } catch (e) {
      emit(GetListDoctorFailure());
    }
  }
}
