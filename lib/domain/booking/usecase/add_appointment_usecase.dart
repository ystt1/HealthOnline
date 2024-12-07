import 'package:dartz/dartz.dart';
import 'package:health_online/core/usecase.dart';
import 'package:health_online/data/booking/models/appointment_create_req.dart';
import 'package:health_online/domain/booking/repository/booking_repository.dart';

import '../../../service_locator.dart';

class AddAppointmentUseCase implements UseCase<Either,AppointmentCreateReq> {
  @override
  Future<Either> call({AppointmentCreateReq? params})async {
    try {
      return await sl<AppointmentRepository>().addAppointment(params!);
    } catch (e) {
      return Left(e);
    }
  }

}