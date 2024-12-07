import 'dart:convert';

import 'package:health_online/common/bloc/auth/user_entity.dart';

class UserModelCreateReq {
  final String email;
  final String password;
  final String fullName;

  const UserModelCreateReq({
    required this.email,
    required this.password,
    required this.fullName,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory UserModelCreateReq.fromMap(Map<String, dynamic> map) {
    return UserModelCreateReq(
      email: map['email'] as String,
      password: map['password'] as String,
      fullName: map['fullName'] as String,
    );
  }
}

extension UserModelCreateReqToEntity on UserModelCreateReq {
  UserEntity toEntity() {
    return UserEntity(
      email: email,
      password: password,
      fullName: fullName,
    );
  }
}
