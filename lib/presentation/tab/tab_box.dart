import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medium_uz/cubits/profile/profile_cubit.dart';
import 'package:medium_uz/cubits/tab/tab_cubit.dart';
import 'package:medium_uz/presentation/tab/profile/profile_screen.dart';
import 'package:medium_uz/presentation/tab/websites/websites_screen.dart';
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
    BlocProvider.of<ProfileCubit>(context).getUserData();
    
    screens = [
      const WebsitesScreen(),
      const ArticlesScreen(),
      const ProfileScreen(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        child: IndexedStack(
          index: context.watch<TabCubit>().state,
          children: screens,
        ),
        listener: (context, state) {
          if (state is AuthUnAuthenticatedState) {
            Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
          }
        },
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r)),
        child: BottomNavigationBar(
          selectedIconTheme: const IconThemeData(
            color: Colors.white
          ),
          selectedItemColor: Colors.white,
          backgroundColor:  AppColors.c_3669C9,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.web), label: "Websites"),
            BottomNavigationBarItem(icon: Icon(Icons.article), label: "Article"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
          currentIndex: context.watch<TabCubit>().state,
          onTap: context.read<TabCubit>().changeTabIndex
        ),
      ),
    );
  }
}