import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nineti_connect/core/configs/assets/app_vectors.dart';
import 'package:nineti_connect/core/configs/theme/app_colors.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';

import 'package:google_fonts/google_fonts.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(FetchUsers(isInitialLoad: true));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        context.read<UserBloc>().add(FetchUsers());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Manage Users',

          style: GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.w900),
        ),
        backgroundColor: AppColors.background,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.componentColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      AppVectors.search,
                      height: 12,
                      width: 12,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  hintText: 'Search users',
                  hintStyle: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryText,
                  ),
                ),
                onChanged: (value) {
                  context.read<UserBloc>().add(SearchUsers(value));
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const Center(
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 3,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    );
                  } else if (state is UserLoaded) {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: state.users.length + (state.hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= state.users.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: SizedBox(
                                width: 32,
                                height: 32,
                                child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 3,
                                  backgroundColor: Colors.grey,
                                ),
                              ),
                            ),
                          );
                        }

                        final user = state.users[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user.image),
                              radius: 24,
                            ),
                            title: Text(
                              '${user.firstName} ${user.lastName}',
                              style: GoogleFonts.manrope(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryText,
                              ),
                            ),
                            subtitle: Text(
                              user.email,
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryText,
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/user-details',
                                arguments: user,
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is UserError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return const SizedBox();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.componentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 132,
                    vertical: 14,
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Add User',
                  style: GoogleFonts.manrope(
                    color: AppColors.primaryText,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
