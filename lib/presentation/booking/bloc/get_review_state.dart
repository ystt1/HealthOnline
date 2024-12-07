import 'package:health_online/domain/booking/entity/review.dart';

abstract class GetReviewState {}

class GetReviewStateInitial extends GetReviewState {}

class GetReviewStateLoading extends GetReviewState {}

class GetReviewStateSuccess extends GetReviewState {
  final List<ReviewEntity> reviews;

  GetReviewStateSuccess({required this.reviews});
}

class GetReviewStateFailure extends GetReviewState {
  final String errorMsg;

  GetReviewStateFailure({required this.errorMsg});
}
