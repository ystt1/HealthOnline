import 'package:health_online/domain/history/entity/prescription_entity.dart';

abstract class GetPrescriptionState{
}

class GetPrescriptionStateLoading extends GetPrescriptionState{}

class GetPrescriptionStateSuccess extends GetPrescriptionState{
  final PrescriptionEntity prescriptionEntity;

  GetPrescriptionStateSuccess({required this.prescriptionEntity});
}

class GetPrescriptionStateFailure extends GetPrescriptionState{
  final String errorMsg;

  GetPrescriptionStateFailure({required this.errorMsg});
}