class ReviewEntity
{
  final String comment;
  final int star;
  final String userName;
  final String dateTime;

  const ReviewEntity({
    required this.comment,
    required this.star,
    required this.userName,
    required this.dateTime,
  });
}