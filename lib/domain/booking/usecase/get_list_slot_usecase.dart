import 'package:dartz/dartz.dart';
import 'package:health_online/core/usecase.dart';
import 'package:health_online/data/booking/models/get_time_slot.dart';
import 'package:health_online/domain/booking/repository/booking_repository.dart';

import '../../../service_locator.dart';

class GetListSlotUseCase implements UseCase<Either, GetTimeSlot> {
  @override
  Future<Either> call({GetTimeSlot? params}) async {
    return await sl<AppointmentRepository>().getTimeSlot(params!);
  }
}
