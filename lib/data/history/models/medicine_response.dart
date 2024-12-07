import 'package:health_online/domain/history/entity/medicine_entity.dart';

class MedicineResponse {
  final String name;
  final String unit;
  final String dosage;
  final int quantity;

  const MedicineResponse({
    required this.name,
    required this.unit,
    required this.dosage,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'unit': this.unit,
      'dosage': this.dosage,
      'quantity': this.quantity,
    };
  }

  factory MedicineResponse.fromMap(Map<String, dynamic> map) {
    return MedicineResponse(
      name: map['name'] as String,
      unit: map['unit'] as String,
      dosage: map['dosage'] as String,
      quantity: map['quantity'] as int,
    );
  }
}

extension MedicineResponseToEntity on MedicineResponse {
  MedicineEntity toEntity() {
    return MedicineEntity(
        name: name, unit: unit, dosage: dosage, quantity: quantity);
  }
}
