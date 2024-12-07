import 'package:dartz/dartz.dart';
import 'package:health_online/core/usecase.dart';
import 'package:health_online/domain/booking/repository/booking_repository.dart';

import '../../../service_locator.dart';

class GetListDoctorUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {

    return await sl<AppointmentRepository>().getListDoctor(params!);

  }
}
