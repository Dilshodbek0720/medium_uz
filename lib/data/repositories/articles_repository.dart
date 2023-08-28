import 'package:medium_uz/data/models/articles/articles_model.dart';

import '../models/universal_data.dart';
import '../network/api_service.dart';

class ArticleRepository {
  final ApiService apiService;

  ArticleRepository({required this.apiService});

  Future<UniversalData> getAllArticles() async => apiService.getAllArticles();

  Future<UniversalData> getArticleById(int articleId) async =>
      apiService.getArticleById(articleId);

  Future<UniversalData> createArticle(ArticleModel articleModel) async =>
      apiService.createArticle(articleModel: articleModel);
}