import 'package:health_online/domain/booking/entity/doctor.dart';

abstract class GetListDoctorState{}

class GetListDoctorInitial implements GetListDoctorState{}

class GetListDoctorLoading implements GetListDoctorState{}

class GetListDoctorSuccess implements GetListDoctorState{
  final List<DoctorEntity> doctors;

  GetListDoctorSuccess({required this.doctors});
}

class GetListDoctorFailure implements GetListDoctorState{}