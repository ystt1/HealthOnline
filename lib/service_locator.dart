import 'package:get_it/get_it.dart';
import 'package:health_online/data/auth/auth_repository_imp/auth_repository_imp.dart';
import 'package:health_online/data/auth/auth_springboot_service/auth_service_springboot.dart';
import 'package:health_online/data/booking/springboot_service/booking_springboot_service.dart';
import 'package:health_online/data/history/repository/history_repository_imp.dart';
import 'package:health_online/data/history/service/history_springboot_service.dart';

import 'package:health_online/data/profile/repository_imp/profile_repository_imp.dart';
import 'package:health_online/data/profile/springboot_service/profile_springboot_service.dart';
import 'package:health_online/domain/auth/repository/auth_repository.dart';
import 'package:health_online/domain/auth/usecase/login_usecase.dart';
import 'package:health_online/domain/auth/usecase/sign_up_usecase.dart';
import 'package:health_online/domain/booking/repository/booking_repository.dart';
import 'package:health_online/domain/booking/usecase/add_appointment_usecase.dart';
import 'package:health_online/domain/booking/usecase/get_list_doctor_usecase.dart';
import 'package:health_online/domain/booking/usecase/get_list_slot_usecase.dart';
import 'package:health_online/domain/booking/usecase/get_review_usecase.dart';
import 'package:health_online/domain/history/repository/history_repository.dart';
import 'package:health_online/domain/history/usecase/add_review_usecase.dart';
import 'package:health_online/domain/history/usecase/get_history_usecase.dart';
import 'package:health_online/domain/history/usecase/get_review_of_user_usecase.dart';
import 'package:health_online/domain/profile/repository/profile_repository.dart';
import 'package:health_online/domain/profile/usecase/change_password_usecase.dart';
import 'package:health_online/domain/profile/usecase/update_profile_usecase.dart';
import 'data/booking/repository_imp/booking_repository_imp.dart';
import 'domain/history/usecase/get_prescription_usecase.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
//service
  sl.registerSingleton<AuthServiceSpringboot>(AuthServiceSpringbootImp());
  sl.registerSingleton<AppointmentSpringbootService>(
      AppointmentSpringbootServiceImp());
  sl.registerSingleton<ProfileSpringbootService>(ProfileSpringbootServiceImp());
  sl.registerSingleton<HistorySpringbootService>(HistorySpringbootServiceImp());
  //repo
  sl.registerSingleton<AuthRepository>(AuthRepositoryImp());
  sl.registerSingleton<AppointmentRepository>(AppointmentRepositoryImp());
  sl.registerSingleton<ProfileRepository>(ProfileRepositoryImp());
  sl.registerSingleton<HistoryRepository>(HistoryRepositoryImp());
  //usecase

  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<LoginUseCase>(LoginUseCase());
  sl.registerSingleton<GetListDoctorUseCase>(GetListDoctorUseCase());
  sl.registerSingleton<GetListSlotUseCase>(GetListSlotUseCase());
  sl.registerSingleton<AddAppointmentUseCase>(AddAppointmentUseCase());
  sl.registerSingleton<ChangePasswordUseCase>(ChangePasswordUseCase());
  sl.registerSingleton<UpdateProfileUseCase>(UpdateProfileUseCase());
  sl.registerSingleton<GetReviewUseCase>(GetReviewUseCase());
  sl.registerSingleton<GetHistoryUseCase>(GetHistoryUseCase());
  sl.registerSingleton<GetPrescriptionUseCase>(GetPrescriptionUseCase());
  sl.registerSingleton<GetReviewOfUserUseCase>(GetReviewOfUserUseCase());
  sl.registerSingleton<AddReviewUseCase>(AddReviewUseCase());
}
