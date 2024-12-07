class DoctorEntity {
  final String id;
  final String name;
  final String description;
  final String specialized;
  final double averageStar;
  final int numberReview;
  final int numberBooking;

  const DoctorEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.specialized,
    required this.averageStar,
    required this.numberReview,
    required this.numberBooking,
  });


}
