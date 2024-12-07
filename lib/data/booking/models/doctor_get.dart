import 'package:health_online/domain/booking/entity/doctor.dart';

class DoctorGet {
  final String id;
  final String name;
  final String description;
  final String specialized;
  final double averageStar;
  final int numberReview;
  final int numberBooking;

  const DoctorGet({
    required this.id,
    required this.name,
    required this.description,
    required this.specialized,
    required this.averageStar,
    required this.numberReview,
    required this.numberBooking,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'specialized': this.specialized,
      'averageStar': this.averageStar,
      'numberReview': this.numberReview,
      'numberBooking': this.numberBooking,
    };
  }

  factory DoctorGet.fromMap(Map<String, dynamic> map) {
    return DoctorGet(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      specialized: map['specialized'] as String,
      averageStar: map['averageStar'] as double,
      numberReview: map['numberReview'] as int,
      numberBooking: map['numberBooking'] as int,
    );
  }
}

extension DoctorGetToDoctorEntity on DoctorGet {
  DoctorEntity toEntity() {
    return DoctorEntity(
        id: id,
        name: name,
        description: description,
        specialized: specialized,
        averageStar: averageStar,
        numberReview: numberReview,
        numberBooking: numberBooking);
  }
}
