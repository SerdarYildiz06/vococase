import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vococase/model/login_response.dart';
import 'package:vococase/service/local_storage_service.dart';

final loginControllerProvider =
    Provider<LoginController>((ref) => LoginController());

class LoginController {
  Future<LoginResponse> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://reqres.in/api/login'),
      body: {
        'email': username,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      await LocalStorageService().set('token', data['token'] as String);

      return LoginResponse.fromMap(data);
    } else {
      throw Exception('Failed to login. Status Code: ${response.statusCode}');
    }
  }
}
