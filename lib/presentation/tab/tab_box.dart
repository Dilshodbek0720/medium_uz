import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medium_uz/cubits/tab/tab_cubit.dart';
import 'package:medium_uz/presentation/tab/profile/profile_screen.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../utils/colors/app_colors.dart';
import '../app_routes.dart';
import 'articles/articles_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> screens = [];

  int currentIndex = 0;

  @override
  void initState() {
    screens = [
      const ArticlesScreen(),
      const ProfileScreen(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        child: screens[context.watch<TabCubit>().state],
        listener: (context, state) {
          if (state is AuthUnAuthenticatedState) {
            Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:  AppColors.c_3669C9,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Article"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: context.watch<TabCubit>().state,
        onTap: context.read<TabCubit>().changeTabIndex
      ),
    );
  }
}