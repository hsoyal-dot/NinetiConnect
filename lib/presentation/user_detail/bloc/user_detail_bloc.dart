import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nineti_connect/data/repo/user_repo.dart';
import 'package:nineti_connect/presentation/user_detail/bloc/user_detail_event.dart';
import 'package:nineti_connect/presentation/user_detail/bloc/user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final UserRepository repository;

  UserDetailBloc(this.repository) : super(const UserDetailState()) {
    on<FetchUserDetails>(_onFetchUserDetails);
  }

  Future<void> _onFetchUserDetails(
      FetchUserDetails event, Emitter<UserDetailState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final posts = await repository.fetchUserPosts(event.userId);
      final todos = await repository.fetchUserTodos(event.userId);
      emit(state.copyWith(posts: posts, todos: todos, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}