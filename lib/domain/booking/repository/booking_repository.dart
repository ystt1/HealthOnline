import 'package:dartz/dartz.dart';
import 'package:health_online/data/booking/models/appointment_create_req.dart';
import 'package:health_online/data/booking/models/get_time_slot.dart';


abstract class AppointmentRepository{
  Future<Either> getListDoctor(String name);
  Future<Either> getTimeSlot(GetTimeSlot timeSlotModel);
  Future<Either> addAppointment(AppointmentCreateReq appointment);

  Future<Either> getListReview(String idDoctor);
}