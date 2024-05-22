import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  saveToken(String token) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'TOKEN', value: token);
  }

  removeToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'TOKEN');
  }

  Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'TOKEN');

    return value ?? '';
  }

  saveUserId(int userId) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'USERID', value: userId.toString());
  }

  removeUserId() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'USERID');
  }

  Future<String> getUserId() async {
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'USERID');
  
    return value ?? '';
  }
}
