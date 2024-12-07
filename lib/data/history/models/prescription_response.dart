import 'package:health_online/data/history/models/medicine_response.dart';
import 'package:health_online/domain/history/entity/prescription_entity.dart';

class PrescriptionResponse {
  final String note;
  final String diagnosis;
  final List<MedicineResponse> medicines;

  PrescriptionResponse(
      {required this.note, required this.diagnosis, required this.medicines});

  Map<String, dynamic> toMap() {
    return {
      'note': this.note,
      'diagnosis': this.diagnosis,
      'medicines': this.medicines,
    };
  }

  factory PrescriptionResponse.fromMap(Map<String, dynamic> map) {
    return PrescriptionResponse(
      note: map['note'] as String,
      diagnosis: map['diagnosis'] as String,
      medicines: (map['medicineInPrescription'] as List)
          .map((medicineMap) => MedicineResponse.fromMap(medicineMap))
          .toList(),
    );
  }
}

extension PrescriptionResponseToEntity on PrescriptionResponse {
  PrescriptionEntity toEntity() {
    return PrescriptionEntity(
        note: note,
        diagnosis: diagnosis,
        medicines: medicines.map((data) => data.toEntity()).toList());
  }
}
