import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vococase/model/user_model.dart';

class UserController {
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Check if the 'data' key exists in the response
      if (data.containsKey('data')) {
        List<dynamic> userList = data['data'];

        List<User> users = userList.map((json) => User.fromJson(json)).toList();
        return users;
      } else {
        throw Exception('Invalid API response format: Missing "data" key');
      }
    } else {
      throw Exception(
          'Failed to load users. Status Code: ${response.statusCode}');
    }
  }
}
