import 'package:dartz/dartz.dart';
import 'package:health_online/core/usecase.dart';
import 'package:health_online/data/history/models/add_review_post.dart';
import 'package:health_online/domain/history/repository/history_repository.dart';

import '../../../service_locator.dart';

class AddReviewUseCase extends UseCase<Either, AddReviewPost> {
  @override
  Future<Either> call({AddReviewPost? params}) async {
    return await sl<HistoryRepository>().addReview(params!);
  }
}
