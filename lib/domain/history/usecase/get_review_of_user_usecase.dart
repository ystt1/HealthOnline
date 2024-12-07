import 'package:dartz/dartz.dart';
import 'package:health_online/core/usecase.dart';
import 'package:health_online/domain/history/repository/history_repository.dart';

import '../../../service_locator.dart';

class GetReviewOfUserUseCase extends UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<HistoryRepository>().getReviewOfUser(params!);
  }
}
