import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:health_online/data/profile/models/change_password_model_req.dart';
import 'package:health_online/data/profile/models/update_profile_model_req.dart';
import '../../../core/constant.dart';
import 'package:http/http.dart' as http;

abstract class ProfileSpringbootService {
  Future<Either> changePassword(ChangePasswordModelReq passwords);

  Future<Either> updateProfile(UpdateProfileModelReq newProfile);
}

class ProfileSpringbootServiceImp extends ProfileSpringbootService {
  @override
  Future<Either> changePassword(ChangePasswordModelReq passwords) async {
    try {
      String body = json.encode(passwords.toMap());
      final uri = Uri.parse('${AppConstant.api}/user/change-password');
      final response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: body);
      if (response.statusCode == 200) {
        return Right(utf8.decode(response.bodyBytes));
      }
      if (response.statusCode == 400) {
        return Left(utf8.decode(response.bodyBytes));
      } else {
        return Left(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> updateProfile(UpdateProfileModelReq newProfile) async {
    try {
      String body = json.encode(newProfile.toMap());
      final uri = Uri.parse('${AppConstant.api}/user/update-profile');
      final response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: body);
      if (response.statusCode == 200) {
        return Right(utf8.decode(response.bodyBytes));
      }
      return Left(response.body);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
