class HistoryEntity {
  final String id;
  final int slot;
  final String date;
  final int status;
  final String doctorName;
  final String specialization;
  final String name;
  final int age;
  final String doctorId;

  const HistoryEntity({
    required this.id,
    required this.slot,
    required this.date,
    required this.status,
    required this.doctorName,
    required this.specialization,
    required this.name,
    required this.age,
    required this.doctorId,
  });
}
