import 'package:medium_uz/utils/export/export.dart';
import 'cubits/articles_fetch/article_fetch_cubit.dart';
import 'cubits/website_fetch/website_fetch_cubit.dart';
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
            create: (context) => ProfileRepository(apiService: apiService),
        ),
        RepositoryProvider(
          create: (context) => ArticleRepository(apiService: apiService),
        ),
        RepositoryProvider(
            create: (context) => WebsiteRepository(apiService: apiService),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ArticleFetchCubit(
              articleRepository: context.read<ArticleRepository>(),
            ),
          ),
          BlocProvider(create: (context) => ArticleAddCubit(
              articleRepository: context.read<ArticleRepository>()),
          ),
          BlocProvider(
              create: (context) => ProfileCubit(
                  profileRepository: context.read<ProfileRepository>(),
              )
          ),
          BlocProvider(create: (context) => TabCubit()),
          BlocProvider(create: (context) => UserDataCubit()),
          BlocProvider(create: (context) => WebsiteAddCubit(
              websiteRepository: context.read<WebsiteRepository>()),
          ),
          BlocProvider(
            create: (context) => WebsiteFetchCubit(
                websiteRepository: context.read<WebsiteRepository>()),
          ),
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
