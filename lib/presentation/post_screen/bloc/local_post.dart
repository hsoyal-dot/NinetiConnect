import 'package:nineti_connect/presentation/user_detail/bloc/user_detail_event.dart';

class AddLocalPost extends UserDetailEvent {
  final String title;
  final String body;

  AddLocalPost(this.title, this.body);

  @override
  List<Object?> get props => [title, body];
}