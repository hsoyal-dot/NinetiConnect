import 'package:equatable/equatable.dart';

abstract class UserDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUserDetails extends UserDetailEvent {
  final int userId;
  FetchUserDetails(this.userId);
}