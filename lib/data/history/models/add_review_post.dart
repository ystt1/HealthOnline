class AddReviewPost {
  final String idDoctor;
  final String idPatient;
  final String comment;
  final int star;

  AddReviewPost({required this.idDoctor, required this.idPatient, required this.comment, required this.star});

  Map<String, dynamic> toMap() {
    return {
      'idDoctor': this.idDoctor,
      'idPatient': this.idPatient,
      'comment': this.comment,
      'star': this.star,
    };
  }

  factory AddReviewPost.fromMap(Map<String, dynamic> map) {
    return AddReviewPost(
      idDoctor: map['idDoctor'] as String,
      idPatient: map['idPatient'] as String,
      comment: map['comment'] as String,
      star: map['star'] as int,
    );
  }
}
