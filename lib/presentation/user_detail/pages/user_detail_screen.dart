import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nineti_connect/data/models/user_list/user_model.dart';
import 'package:nineti_connect/data/repo/user_repo.dart';
import 'package:nineti_connect/presentation/user_detail/bloc/user_detail_bloc.dart';
import 'package:nineti_connect/presentation/user_detail/bloc/user_detail_event.dart';
import 'package:nineti_connect/presentation/user_detail/bloc/user_detail_state.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as UserModel;

    return BlocProvider(
      create: (context) => UserDetailBloc(context.read<UserRepository>())
        ..add(FetchUserDetails(user.id)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('${user.firstName} ${user.lastName}'),
        ),
        body: BlocBuilder<UserDetailBloc, UserDetailState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.error != null) {
              return Center(child: Text('Error: ${state.error}'));
            }

            return Column(
              children: [
                // User Info
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.image),
                    radius: 30,
                  ),
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text(user.email),
                ),
                // Tabs
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const TabBar(tabs: [
                          Tab(text: 'Posts'),
                          Tab(text: 'Todos'),
                        ]),
                        Expanded(
                          child: TabBarView(
                            children: [
                              ListView(
                                children: state.posts
                                    .map((post) => ListTile(
                                          title: Text(post.title),
                                          subtitle: Text(post.body),
                                        ))
                                    .toList(),
                              ),
                              ListView(
                                children: state.todos
                                    .map((todo) => CheckboxListTile(
                                          title: Text(todo.todo),
                                          value: todo.completed,
                                          onChanged: null,
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}