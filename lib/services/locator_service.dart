import 'package:get_it/get_it.dart';
import 'package:medium_uz/data/network/open_api_service.dart';
import 'package:medium_uz/data/network/secure_api_service.dart';
import 'package:medium_uz/utils/export/export.dart';

final getIt = GetIt.instance;

Future<void> getItSetup() async{
  getIt.registerLazySingleton<OpenApiService>(() => OpenApiService());
  getIt.registerLazySingleton<SecureApiService>(() => SecureApiService());
  getIt.registerLazySingleton<ArticleRepository>(() => ArticleRepository());
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
  getIt.registerLazySingleton<WebsiteRepository>(() => WebsiteRepository());
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepository());
}
