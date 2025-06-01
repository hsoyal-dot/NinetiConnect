import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nineti_connect/core/configs/theme/app_colors.dart';
import 'package:nineti_connect/data/repo/user_repo.dart';
import 'package:nineti_connect/presentation/user_detail/pages/user_detail_screen.dart';
import 'package:nineti_connect/presentation/users/bloc/user_bloc.dart';
import 'package:nineti_connect/presentation/users/pages/user_list_screen.dart';

void main() {
  runApp(
    RepositoryProvider(create: (_) => UserRepository(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Management',
      theme: ThemeData(scaffoldBackgroundColor: AppColors.background),
      home: BlocProvider(
        create: (context) => UserBloc(context.read<UserRepository>()),
        child: const UserListScreen(),
      ),
      routes: {'/user-details': (context) => const UserDetailScreen()},
    );
  }
}
