// ignore: depend_on_referenced_packages
import 'dart:convert' show jsonDecode, jsonEncode;
// ignore: depend_on_referenced_packages
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore: depend_on_referenced_packages, implementation_imports
import 'package:http/src/response.dart';
import 'package:tsport_mobile_app/models/account.dart';
import 'package:tsport_mobile_app/utils/custom_client.dart';

class AuthService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  Account? account;

  AuthService();

  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: 'jwt', value: token);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'jwt');
  }

  Future<Response> callWhoAmI() async {
    final token = await getAccessToken();

    final client = CustomClient({
      'Authorization': 'Bearer $token',
    });

    final response = await client.get(Uri.parse('/auth/who-am-i'));

    client.close();

    return response;
  }

  Future<Response> callLogin(String email, String password) async {
    final client = CustomClient({});

    final response = await client.post(Uri.parse('/auth/login'),
        body: jsonEncode({"email": email, "password": password}));

    client.close();

    return response;
  }

  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null;
  }

  Future<bool> checkAuthorize(String role) async {
    final response = await callWhoAmI();

    if (response.statusCode != 200) {
      return false;
    }

    final responseBody = jsonDecode(response.body);
    account ??= Account.fromJson(responseBody);

    return (account?.role != null && account?.role == role);
  }
}
