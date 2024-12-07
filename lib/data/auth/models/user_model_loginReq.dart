import 'dart:convert';

class UserModelLoginReq{
  final String email;
  final String password;

  const UserModelLoginReq({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
  String toJson() {
    return json.encode(toMap());
  }

  factory UserModelLoginReq.fromMap(Map<String, dynamic> map) {
    return UserModelLoginReq(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

}