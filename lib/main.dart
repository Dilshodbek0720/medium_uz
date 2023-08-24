import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medium_uz/cubits/articles/articles_cubit.dart';
import 'package:medium_uz/cubits/tab/tab_cubit.dart';
import 'package:medium_uz/cubits/user_data/user_data_cubit.dart';
import 'package:medium_uz/data/local/storage_repository.dart';
import 'package:medium_uz/data/network/api_service.dart';
import 'package:medium_uz/data/repositories/articles_repository.dart';
import 'package:medium_uz/presentation/app_routes.dart';
import 'package:medium_uz/utils/theme.dart';

import 'cubits/auth/auth_cubit.dart';
import 'data/repositories/auth_repository.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();

  runApp(App(apiService: ApiService(),));
}


class App extends StatelessWidget {
  const App({super.key, required this.apiService});

  final ApiService apiService;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(apiService: apiService),
        ),
        RepositoryProvider(
          create: (context) => ArticleRepository(apiService: apiService),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ArticleCubit(
              articleRepository: context.read<ArticleRepository>(),
            ),
          ),
          BlocProvider(
              create: (context) => TabCubit()
          ),
          BlocProvider(
              create: (context) => UserDataCubit()
          )
        ],
        child: const MyApp(),
      ),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.dark,
          onGenerateRoute: AppRoutes.generateRoute,
          initialRoute: RouteNames.splashScreen,
        );
      },
    );
  }
}
