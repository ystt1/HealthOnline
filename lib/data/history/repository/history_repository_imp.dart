import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:health_online/data/history/models/add_review_post.dart';
import 'package:health_online/data/history/models/history_response.dart';
import 'package:health_online/data/history/models/prescription_response.dart';
import 'package:health_online/data/history/models/star_comment_model.dart';
import 'package:health_online/data/history/service/history_springboot_service.dart';
import 'package:health_online/domain/history/entity/prescription_entity.dart';
import 'package:health_online/domain/history/entity/star_comment_entity.dart';
import 'package:health_online/domain/history/repository/history_repository.dart';

import '../../../service_locator.dart';

class HistoryRepositoryImp extends HistoryRepository {
  @override
  Future<Either> getHistory(String userId) async {
    try {
      var historiesModel =
          await sl<HistorySpringbootService>().getHistory(userId);
      return historiesModel.fold((error) => Left(error), (data) {
        final historiesEntity = (data as List<HistoryResponse>)
            .map((HistoryResponse model) => model.toEntity())
            .toList();
        return Right(historiesEntity);
      });
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> getPrescription(String appointmentId) async {
    try {
      var prescriptionModel =
          await sl<HistorySpringbootService>().getPrescription(appointmentId);
      return prescriptionModel.fold((error) => Left(error), (data) {
        final PrescriptionEntity prescription =
            (data as PrescriptionResponse).toEntity();

        return Right(prescription);
      });
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> getReviewOfUser(String doctorId) async {
    try {
      var starCommentModel =
          await sl<HistorySpringbootService>().getReviewOfUser(doctorId);

      return starCommentModel.fold((error) => Left(error), (data) {
        final StarCommentEntity starCommentEntity =
            (data as StarCommentModel).toEntity();
        return Right(starCommentEntity);
      });
    } catch (e) {

      return Left(e);
    }
  }

  @override
  Future<Either> addReview(AddReviewPost review) async {
    return await sl<HistorySpringbootService>().addReview(review);
  }
}
