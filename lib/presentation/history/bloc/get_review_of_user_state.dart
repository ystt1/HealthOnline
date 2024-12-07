
import 'package:health_online/domain/history/entity/star_comment_entity.dart';

abstract class GetReviewOfUserState{}

class GetReviewOfUserStateLoading extends GetReviewOfUserState{}

class GetReviewOfUserStateSuccess extends GetReviewOfUserState{
  final StarCommentEntity starCommentEntity;

  GetReviewOfUserStateSuccess({required this.starCommentEntity});
}

class GetReviewOfUserStateFailure extends GetReviewOfUserState{
  final String errorMsg;

  GetReviewOfUserStateFailure({required this.errorMsg});
}