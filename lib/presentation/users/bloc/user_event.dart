import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUsers extends UserEvent {
  final bool isInitialLoad;
  FetchUsers({this.isInitialLoad = false});
}

class SearchUsers extends UserEvent {
  final String query;
  SearchUsers(this.query);

  @override
  List<Object?> get props => [query];
}