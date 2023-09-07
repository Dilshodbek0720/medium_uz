import 'package:get_it/get_it.dart';
import 'package:medium_uz/utils/export/export.dart';

final getIt = GetIt.instance;

Future<void> getItSetup() async{
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<ArticleRepository>(() => ArticleRepository(apiService: ApiService()));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(apiService: ApiService()));
  getIt.registerLazySingleton<WebsiteRepository>(() => WebsiteRepository(apiService: ApiService()));
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepository(apiService: ApiService()));
}
