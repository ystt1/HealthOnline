import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:health_online/core/constant.dart';
import 'package:health_online/core/user_storage.dart';
import 'package:health_online/data/history/models/add_review_post.dart';
import 'package:health_online/data/history/models/history_response.dart';
import 'package:health_online/data/history/models/prescription_response.dart';
import 'package:health_online/data/history/models/star_comment_model.dart';
import 'package:http/http.dart' as http;

abstract class HistorySpringbootService {
  Future<Either> getHistory(String userId);

  Future<Either> getPrescription(String id);

  Future<Either> getReviewOfUser(String doctorId);

  Future<Either> addReview(AddReviewPost review);
}

class HistorySpringbootServiceImp extends HistorySpringbootService {
  @override
  Future<Either> getHistory(String userId) async {
    try {
      final uri = Uri.parse(
          "${AppConstant.api}/appointment/get-history?userId=$userId");
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> responseBody =
            json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;

        final histories = responseBody
            .map((history) => HistoryResponse.fromMap(history))
            .toList();
        return Right(histories);
      }
      return const Left("Something went wrong");
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> getPrescription(String id) async {
    try {
      final uri = Uri.parse(
          "${AppConstant.api}/prescription/get-prescription?idAppointment=$id");
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody =
            json.decode(utf8.decode(response.bodyBytes));

        final prescription = PrescriptionResponse.fromMap(responseBody);

        return Right(prescription);
      }
      return const Left("Something went wrong");
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> getReviewOfUser(String doctorId) async {
    try {
      final uri = Uri.parse(
          "${AppConstant.api}/get-a-review?doctorId=$doctorId&patientId=${UserStorage.getId()}");
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody =
            json.decode(utf8.decode(response.bodyBytes));
        final starComment = StarCommentModel.fromMap(responseBody);
        return Right(starComment);
      }
      if (response.statusCode == 204) {
        return Right(new StarCommentModel(comment: "", star: -1));
      }
      return const Left("Something went wrong");
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> addReview(AddReviewPost review) async {
    try {
      var body = json.encode(review.toMap());
      final uri = Uri.parse("${AppConstant.api}/add-review");
      final response = await http.post(uri,headers: {
        'Content-Type': 'application/json',
      }, body: body);
      final String responseBody =
          utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        print(responseBody);
        return const Right("add review success");
      }
      print(responseBody.toString());
      return Left(responseBody.toString());
    } catch (e) {
      print(e.toString());
      return Left(e);
    }
  }
}
