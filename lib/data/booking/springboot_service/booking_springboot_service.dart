import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:health_online/core/constant.dart';
import 'package:health_online/data/booking/models/appointment_create_req.dart';
import 'package:health_online/data/booking/models/review_response.dart';
import 'package:http/http.dart' as http;

import '../models/doctor_get.dart';
import '../models/get_time_slot.dart';

abstract class AppointmentSpringbootService {
  Future<Either> getListDoctor(String name);

  Future<Either> getTimeSlot(GetTimeSlot timeSlot);

  Future<Either> addAppointment(AppointmentCreateReq appointment);

  Future<Either> getListReview(String idDoctor);
}

class AppointmentSpringbootServiceImp extends AppointmentSpringbootService {
  @override
  Future<Either> getListDoctor(String name) async {
    try {
      final uri = Uri.parse('${AppConstant.api}/user/get-list-doctor?name=$name');
      final response = await http.get(uri);


      if (response.statusCode == 200) {
        final List<dynamic> responseBody =
        json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;

        final doctors =
        responseBody.map((data) => DoctorGet.fromMap(data)).toList();
        return Right(doctors);
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        return Left(responseBody["message"] ?? "Unknown error");
      }
    } catch (e) {

      return Left(e);
    }
  }

  @override
  Future<Either> getTimeSlot(GetTimeSlot timeSlot) async {
    try {
      final uri = Uri.parse(
          '${AppConstant.api}/appointment/getTimeSlot?doctorId=${timeSlot
              .idDoctor}&xDayLater=${timeSlot.xDayLater}');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> dynamicList = jsonDecode(utf8.decode(response.bodyBytes));
        List<int> intList = dynamicList.cast<int>();
        return Right(intList);
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        return Left(responseBody["message"] ?? "Unknown error");
      }
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> addAppointment(AppointmentCreateReq appointment) async {
    try {
      String body = json.encode(appointment.toMap());
      final uri = Uri.parse(
          '${AppConstant.api}/appointment/addAppointment');
      final response = await http.post(uri,headers: {
        'Content-Type': 'application/json',
      },body: body
      );
      if (response.statusCode == 201) {
        return const Right('Booking Success');
      }
      if(response.statusCode==409)
      {
        return Left('Appointment is already taken');
      }
      else {
        return Left(response.body);
      }
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> getListReview(String idDoctor) async {
    try {
      final uri = Uri.parse('${AppConstant.api}/get-review?doctorId=$idDoctor');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> responseBody =
        json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
        final reviews =
        responseBody.map((data) => ReviewResponse.fromMap(data)).toList();

        return Right(reviews);
      } else {

        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        return Left(responseBody["message"] ?? "Unknown error");
      }
    } catch (e) {
      print(e.toString());
      return Left(e);
    }
  }
}
