import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nineti_connect/core/configs/assets/app_vectors.dart';
import 'package:nineti_connect/core/configs/theme/app_colors.dart';
import 'package:nineti_connect/data/models/user_list/user_model.dart';
import 'package:nineti_connect/data/repo/user_repo.dart';
import 'package:nineti_connect/presentation/post_screen/bloc/local_post.dart';
import 'package:nineti_connect/presentation/user_detail/bloc/user_detail_bloc.dart';
import 'package:nineti_connect/presentation/user_detail/bloc/user_detail_event.dart';
import 'package:nineti_connect/presentation/user_detail/bloc/user_detail_state.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as UserModel;

    return BlocProvider(
      create: (context) =>
          UserDetailBloc(context.read<UserRepository>())
            ..add(FetchUserDetails(user.id)),
      child: Scaffold(
        body: BlocBuilder<UserDetailBloc, UserDetailState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.error != null) {
              return Center(child: Text('Error: ${state.error}'));
            }

            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 16, 20),
              child: Column(
                children: [
                  // Custom Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 0,
                      // horizontal: 16.0,
                      // vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Text(
                          'User Profile',
                          style: GoogleFonts.manrope(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SvgPicture.asset(AppVectors.settings),
                      ],
                    ),
                  ),
                  // User Info
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 12, 12, 3),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(user.image),
                              radius: 70,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0,0,0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${user.firstName} ${user.lastName}',
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0,0,0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.email,
                              style: GoogleFonts.dmSans(
                                color: AppColors.secondaryText,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.componentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.fromLTRB(130, 14, 130, 14)
                        ),
                        onPressed: () async{
                          final result = await Navigator.pushNamed(context, '/create-post');
                          if(result != null && context.mounted){
                            final newPost = result as Map<String, String>;

                            //TODO: Add Bloc
                            context.read<UserDetailBloc>().add(AddLocalPost(
                              newPost['title']!,
                              newPost['body']!,
                            ));
                          }  
                        },
                        child: Text(
                          'Create Post',
                          style: GoogleFonts.manrope(
                            color: AppColors.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                  // Tabs
                  Expanded(
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          TabBar(
                            labelColor: AppColors.primaryText,
                            unselectedLabelColor: AppColors.secondaryText,
                            indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(width: 2.5, color: AppColors.primaryText),
                              insets: EdgeInsets.symmetric(horizontal: 20),
                            ),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelStyle: GoogleFonts.manrope(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            unselectedLabelStyle: GoogleFonts.manrope(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            tabs: const [
                              Tab(text: 'Posts'),
                              Tab(text: 'Todos'),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                RefreshIndicator(
                                  color: AppColors.primaryText,
                                  backgroundColor: AppColors.componentColor,
                                  strokeWidth: 2,
                                  displacement: 30,
                                  onRefresh: () async {
                                    context.read<UserDetailBloc>().add(FetchUserDetails(user.id));
                                  },
                                  child: ListView(
                                    children: state.posts
                                        .map(
                                          (post) => ListTile(
                                            title: Text(post.title),
                                            subtitle: Text(post.body),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                RefreshIndicator(
                                  color: AppColors.primaryText,
                                  backgroundColor: AppColors.componentColor,
                                  strokeWidth: 2,
                                  displacement: 30,
                                  onRefresh: () async {
                                    context.read<UserDetailBloc>().add(FetchUserDetails(user.id));
                                  },
                                  child: ListView(
                                    children: state.todos
                                        .map(
                                          (todo) => CheckboxListTile(
                                            title: Text(todo.todo),
                                            value: todo.completed,
                                            onChanged: null,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
