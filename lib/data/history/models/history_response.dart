import 'package:health_online/domain/history/entity/history_entity.dart';

class HistoryResponse {
  final String id;
  final int slot;
  final String date;
  final int status;
  final String doctorName;
  final String specialization;
  final String name;
  final int age;
  final String doctorId;


  const HistoryResponse({
    required this.id,
    required this.slot,
    required this.date,
    required this.status,
    required this.doctorName,
    required this.specialization,
    required this.name,
    required this.age,
    required this.doctorId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'slot': this.slot,
      'date': this.date,
      'status': this.status,
      'doctorName': this.doctorName,
      'specialization': this.specialization,
      'name': this.name,
      'age': this.age,
      'doctorId': this.doctorId,
    };
  }

  factory HistoryResponse.fromMap(Map<String, dynamic> map) {
    return HistoryResponse(
      id: map['id'] as String,
      slot: map['slot'] as int,
      date: map['date'] as String,
      status: map['status'] as int,
      doctorName: map['doctorName'] as String,
      specialization: map['specialization'] as String,
      name: map['name'] as String,
      age: map['age'] as int,
      doctorId: map['doctorId'] as String,
    );
  }
}

extension HistoryResponseToEntity on HistoryResponse {
  HistoryEntity toEntity() {
    return HistoryEntity(id: id,
        slot: slot,
        date: date,
        status: status,
        doctorName: doctorName,
        specialization: specialization,
        name: name,
        age: age,
        doctorId: doctorId);
  }
}
