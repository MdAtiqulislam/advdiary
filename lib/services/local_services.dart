import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_data_model.dart';


class LocalServices {
  static const _keyToken = 'token';
  static const _keyEmail = 'email';
  static const _keyPassword = 'password';
  static const _keyUser = 'user';
  static const _keyRememberMe = 'rememberMe';

  // Store token
  static Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
  }

  // Get token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  // Store remember me
  static Future<void> storeRememberMe(bool rememberMe) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyRememberMe, rememberMe);
  }

  // Get remember me
  static Future<bool> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyRememberMe) ?? false;
  }

  // Store email
  static Future<void> storeEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
  }

  // Get email
  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  // Store password
  static Future<void> storePassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPassword, password);
  }

  // Get password
  static Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPassword);
  }

  // Store user
  Future<void> storeUser(UserDataModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final value = json.encode(user.toJson());
    await prefs.setString(_keyUser, value);
  }

  // Get user
  static Future<UserDataModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_keyUser);
    if (value == null) return null;
    return UserDataModel.fromJson(json.decode(value));
  }

  // Delete all
  static Future<void> deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Delete data but keep email/password if remember me is true
  static Future<void> deleteDataBasedOnRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    bool rememberMe = prefs.getBool(_keyRememberMe) ?? false;

    if (rememberMe) {
      String? email = prefs.getString(_keyEmail);
      String? password = prefs.getString(_keyPassword);

      await prefs.clear();

      if (email != null) {
        await prefs.setString(_keyEmail, email);
      }
      if (password != null) {
        await prefs.setString(_keyPassword, password);
      }
      await prefs.setBool(_keyRememberMe, true);
    } else {
      await prefs.clear();
    }
  }
}
