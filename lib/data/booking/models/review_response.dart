import 'package:health_online/domain/booking/entity/review.dart';

class ReviewResponse{
  final String comment;
  final int star;
  final String userName;
  final String createdDate;

  const ReviewResponse({
    required this.comment,
    required this.star,
    required this.userName,
    required this.createdDate,
  });



  factory ReviewResponse.fromMap(Map<String, dynamic> map) {
    return ReviewResponse(
      comment: map['comment'] as String,
      star: map['star'] as int,
      userName: map['userName'] as String? ??"notFound",
      createdDate: map['date'] as String? ??"notFound",
    );
  }

}

extension ReviewResponseToEntity on ReviewResponse {
  ReviewEntity toEntity() {
   return ReviewEntity(comment: comment, star: star, userName: userName, dateTime: createdDate);
  }
}