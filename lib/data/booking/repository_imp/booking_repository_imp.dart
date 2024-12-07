import 'package:dartz/dartz.dart';
import 'package:health_online/data/booking/models/appointment_create_req.dart';
import 'package:health_online/data/booking/models/doctor_get.dart';
import 'package:health_online/data/booking/models/get_time_slot.dart';
import 'package:health_online/data/booking/models/review_response.dart';
import 'package:health_online/data/booking/springboot_service/booking_springboot_service.dart';
import 'package:health_online/domain/booking/repository/booking_repository.dart';

import '../../../service_locator.dart';

class AppointmentRepositoryImp extends AppointmentRepository {
  @override
  Future<Either> getListDoctor(String name) async {
    try {
      var response;
      response = await sl<AppointmentSpringbootService>().getListDoctor(name);
      return response.fold((error) => Left(error), (data) {
        final doctors = (data as List<DoctorGet>)
            .map((DoctorGet e) => e.toEntity())
            .toList();
        return Right(doctors);
      });
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> getTimeSlot(GetTimeSlot timeSlot)async {
    try {
      return await sl<AppointmentSpringbootService>().getTimeSlot(timeSlot);
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> addAppointment(AppointmentCreateReq appointment) async{
    try {
      return await sl<AppointmentSpringbootService>().addAppointment(appointment);
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> getListReview(String idDoctor) async {
    try {
      var response;
      response = await sl<AppointmentSpringbootService>().getListReview(idDoctor);
      return response.fold((error) => Left(error), (data) {
        final reviews = (data as List<ReviewResponse>)
            .map((ReviewResponse e) => e.toEntity())
            .toList();
        return Right(reviews);
      });
    } catch (e) {

      return Left(e);
    }
  }
}
