import 'package:health_online/domain/history/entity/star_comment_entity.dart';

class StarCommentModel {
  final String comment;
  final int star;

  StarCommentModel({required this.comment, required this.star});

  Map<String, dynamic> toMap() {
    return {
      'comment': this.comment,
      'star': this.star,
    };
  }

  factory StarCommentModel.fromMap(Map<String, dynamic> map) {
    return StarCommentModel(
      comment: map['comment'] as String,
      star: map['star'] as int,
    );
  }
}

extension StarCommentModelToEntity on StarCommentModel {
  StarCommentEntity toEntity() {
    return StarCommentEntity(comment: comment, star: star);
  }
}
