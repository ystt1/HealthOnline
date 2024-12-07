import 'package:health_online/core/user_storage.dart';

class AppointmentCreateReq {
  final String? userId = UserStorage.getId();
  final String doctorId;
  final DateTime dayBooking;
  final int hourBooking;
  final String victimName;
  final String description;
  final int age;

  AppointmentCreateReq({
    required this.doctorId,
    required this.dayBooking,
    required this.hourBooking,
    required this.victimName,
    required this.description,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
      'doctorId': this.doctorId,
      'dayBooking': this.dayBooking.toString().split(' ')[0],
      'hourBooking': this.hourBooking,
      'victimName': this.victimName,
      'description': this.description,
      'age': this.age,
    };
  }
}
