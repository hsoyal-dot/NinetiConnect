import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nineti_connect/data/models/user_list/user_model.dart';
import 'package:nineti_connect/data/models/user_detail/post_model.dart';
import 'package:nineti_connect/data/models/user_detail/todo_model.dart';

class UserRepository {
  final baseUrl = 'https://dummyjson.com/users';

  // This one is for user_list screen
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


 //THIS one is for user_detail screenn
  Future<List<PostModel>> fetchUserPosts(int userId) async {
    final response = await http.get(Uri.parse('https://dummyjson.com/posts/user/$userId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List posts = data['posts'];
      return posts.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load user posts.');
    }
  }

  Future<List<TodoModel>> fetchUserTodos(int userId) async {
    final response = await http.get(Uri.parse('https://dummyjson.com/todos/user/$userId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List todos = data['todos'];
      return todos.map((json) => TodoModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load user todos.');
    }
  }
}
