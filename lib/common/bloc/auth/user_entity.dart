class UserEntity {
  final String email;
  final String password;
  final String? fullName;

  const UserEntity({
    required this.email,
    required this.password,
    required this.fullName,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'password': this.password,
      'fullName': this.fullName,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      email: map['email'] as String,
      password: map['password'] as String,
      fullName: map['fullName'] as String,
    );
  }
}