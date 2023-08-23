import '../models/universal_data.dart';
import '../network/api_service.dart';

class ArticleRepository {
  final ApiService apiService;

  ArticleRepository({required this.apiService});

  Future<UniversalData> getAllArticles() async => apiService.getAllArticles();
}