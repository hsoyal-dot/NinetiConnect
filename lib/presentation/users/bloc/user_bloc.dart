import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nineti_connect/data/models/user_model.dart';
import 'package:nineti_connect/data/repo/user_repo.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  int skip = 0;
  final int limit = 10;
  bool isFetching = false;
  List<UserModel> allUsers = [];

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<SearchUsers>(_onSearchUsers);
  }

  void _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    if (isFetching) return;
    isFetching = true;

    try {
      if (event.isInitialLoad) {
        skip = 0;
        allUsers.clear();
        emit(UserLoading());
      }

      final users = await userRepository.fetchUsers(limit: limit, skip: skip);
      skip += limit;

      allUsers.addAll(users);

      emit(UserLoaded(List.from(allUsers), hasMore: users.length == limit));
    } catch (e) {
      emit(UserError(e.toString()));
    }

    isFetching = false;
  }

  void _onSearchUsers(SearchUsers event, Emitter<UserState> emit) {
    final filtered = allUsers.where((user) {
      final name = '${user.firstName} ${user.lastName}'.toLowerCase();
      return name.contains(event.query.toLowerCase());
    }).toList();

    emit(UserLoaded(filtered, hasMore: false));
  }
}