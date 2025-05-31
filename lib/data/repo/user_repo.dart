import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nineti_connect/data/models/user_model.dart';

class UserRepository {
  final baseUrl = 'https://dummyjson.com/users';

  Future<List<UserModel>> fetchUsers({int limit = 10, int skip = 0}) async {
    final response = await http.get(
      Uri.parse('$baseUrl?limit=$limit&skip=$skip'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List users = data['users'];
      return users.map((json) => UserModel.fromJson(json)).toList();
    }else{
      throw Exception('Failed to load user details.');
    }
  }
}
