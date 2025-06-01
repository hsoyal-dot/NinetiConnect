import 'package:equatable/equatable.dart';
import 'package:nineti_connect/data/models/user_detail/post_model.dart';
import 'package:nineti_connect/data/models/user_detail/todo_model.dart';

class UserDetailState extends Equatable {
  final List<PostModel> posts;
  final List<TodoModel> todos;
  final bool isLoading;
  final String? error;

  const UserDetailState({
    this.posts = const [],
    this.todos = const [],
    this.isLoading = false,
    this.error,
  });

  UserDetailState copyWith({
    List<PostModel>? posts,
    List<TodoModel>? todos,
    bool? isLoading,
    String? error,
  }) {
    return UserDetailState(
      posts: posts ?? this.posts,
      todos: todos ?? this.todos,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [posts, todos, isLoading, error];
}