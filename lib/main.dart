import 'package:medium_uz/utils/export/export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();
  await getItSetup();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ArticleFetchCubit()),
        BlocProvider(create: (context) => ArticleAddCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => TabCubit()),
        BlocProvider(create: (context) => UserDataCubit()),
        BlocProvider(create: (context) => WebsiteAddCubit()),
        BlocProvider(create: (context) => WebsiteFetchCubit())
      ],
      child: const MyApp(),
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
