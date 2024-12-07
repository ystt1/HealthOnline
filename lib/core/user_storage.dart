import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setEmail(String email) async =>
      await _preferences?.setString('email', email);

  static String? getEmail() => _preferences?.getString('email');

  static Future setId(String email) async =>
      await _preferences?.setString('id', email);

  static String? getId() => _preferences?.getString('id');

  static Future setFullName(String email) async =>
      await _preferences?.setString('fullName', email);

  static String? getFullName() => _preferences?.getString('fullName');

  static Future setPhoneNumber(String email) async =>
      await _preferences?.setString('phoneNumber', email);

  static String? getPhoneNumber() => _preferences?.getString('phoneNumber');

  static Future setIsLogged(bool isLogged) async =>
      await _preferences?.setBool('isLogged', isLogged);

  static bool? getIsLogged() => _preferences?.getBool('isLogged');
}
