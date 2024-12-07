import 'package:dartz/dartz.dart';
import 'package:health_online/data/history/models/add_review_post.dart';

abstract class HistoryRepository{
  Future<Either> getHistory(String userId);
  Future<Either> getPrescription(String appointmentId);
  Future<Either> getReviewOfUser(String doctorId);
  Future<Either> addReview(AddReviewPost review);
}