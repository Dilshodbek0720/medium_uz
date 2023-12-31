import 'package:medium_uz/utils/export/export.dart';
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
            size: 28,
            color: Colors.white
          ),
          unselectedIconTheme: const IconThemeData(
            color: Colors.white
          ),
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,
          backgroundColor:  AppColors.black,
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