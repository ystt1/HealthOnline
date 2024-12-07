import 'package:health_online/domain/history/entity/medicine_entity.dart';

class PrescriptionEntity {
  final String note;
  final String diagnosis;
  final List<MedicineEntity> medicines;

  const PrescriptionEntity({
    required this.note,
    required this.diagnosis,
    required this.medicines,
  });
}