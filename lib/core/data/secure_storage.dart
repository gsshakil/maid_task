import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:maids_task/core/constants/app_constants.dart';

class SecureStorage {
  saveToken(String token) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: tokenKey, value: token);
  }

  removeToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: tokenKey);
  }

  Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: tokenKey);

    return value ?? '';
  }

  saveUserId(int userId) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: userIdKey, value: userId.toString());
  }

  removeUserId() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: userIdKey);
  }

  Future<String> getUserId() async {
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: userIdKey);
  
    return value ?? '';
  }
}
