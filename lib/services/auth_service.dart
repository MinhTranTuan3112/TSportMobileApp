// ignore: depend_on_referenced_packages
// ignore_for_file: implementation_imports
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:http/src/response.dart';
import 'package:tsport_mobile_app/utils/custom_client.dart';

class AuthService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthService();
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: 'jwt', value: token);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'jwt');
  }

  Future<Response> callLogin(String email, String password) async {
    final client = CustomClient({});

    final response = await client.post(Uri.parse('/auth/login'),
         body: jsonEncode({"email": email, "password": password}));
    client.close();

    // final response = await http.post(
    //   Uri.parse('http://localhost:8080/api/auth/login'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode({"email": email, "password": password}),
    // );


    return response;
  }
}
