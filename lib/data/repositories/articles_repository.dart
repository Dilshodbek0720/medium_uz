import 'package:medium_uz/data/models/articles/articles_model.dart';
import 'package:medium_uz/data/network/open_api_service.dart';
import 'package:medium_uz/data/network/secure_api_service.dart';
import 'package:medium_uz/services/locator_service.dart';

import '../models/universal_data.dart';

class ArticleRepository {

  Future<UniversalData> getAllArticles() async => getIt.get<OpenApiService>().getArticles();

  Future<UniversalData> getArticleById(int articleId) async =>
      getIt.get<SecureApiService>().getArticleById(articleId);

  Future<UniversalData> createArticle(ArticleModel articleModel) async =>
      getIt.get<SecureApiService>().createArticle(articleModel: articleModel);
}