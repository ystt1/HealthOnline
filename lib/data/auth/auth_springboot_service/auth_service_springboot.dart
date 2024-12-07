import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:health_online/core/user_storage.dart';

import 'package:health_online/data/auth/models/user_model_createReq.dart';
import 'package:health_online/data/auth/models/user_model_loginReq.dart';
import 'package:http/http.dart' as http;

abstract class AuthServiceSpringboot {
  Future<Either> signUp(UserModelCreateReq user);

  Future<Either> login(UserModelLoginReq user);
}

class AuthServiceSpringbootImp extends AuthServiceSpringboot {
  final String api = 'http://localhost:8080/user';

  @override
  Future<Either> signUp(UserModelCreateReq user) async {
    try {
      String request = user.toJson();
      final uri = Uri.parse(api);
      final response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: request);
      final Map<String, dynamic> responseBody =
          jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        UserStorage.setId(responseBody['user']['id'] ?? '');
        UserStorage.setPhoneNumber(
            (responseBody['user']['phoneNumber']) ?? 'Didn\'t add phoneNumber');
        return Right(
            UserModelCreateReq.fromMap(responseBody['user']).toEntity());
      } else {
        return Left(responseBody['message'] ?? "Unknown error");
      }
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> login(UserModelLoginReq user) async {
    try {
      final uri =
          Uri.parse('$api/login?email=${user.email}&password=${user.password}');
      final response = await http.get(uri);
      final Map<String, dynamic> responseBody =
          jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        UserStorage.setId(responseBody['user']['id']);
        UserStorage.setPhoneNumber(
            (responseBody['user']['phoneNumber']) ?? 'Didn\'t add phoneNumber');
        return Right(
            UserModelCreateReq.fromMap(responseBody['user']).toEntity());
      } else {
        return Left(responseBody["message"] ?? "Unknown error");
      }
    } catch (e) {
      return Left(e);
    }
  }
}
