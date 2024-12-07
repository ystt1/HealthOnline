import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online/domain/history/usecase/get_prescription_usecase.dart';
import 'package:health_online/presentation/history/bloc/get_prescription_state.dart';

import '../../../service_locator.dart';

class GetPrescriptionCubit extends Cubit<GetPrescriptionState> {
  GetPrescriptionCubit() : super(GetPrescriptionStateLoading());

  Future<void> onLoading(String id) async {
    try {
      final response = await sl<GetPrescriptionUseCase>().call(params: id);

      response.fold(
          (error) => emit(GetPrescriptionStateFailure(errorMsg: error)),
          (data) =>
              emit(GetPrescriptionStateSuccess(prescriptionEntity: data)));
    } catch (e) {

      emit(GetPrescriptionStateFailure(errorMsg: e.toString()));
    }
  }
}
