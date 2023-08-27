import 'package:medium_uz/data/models/websites/website_model.dart';
import 'package:medium_uz/data/network/api_service.dart';
import '../models/universal_data.dart';

class WebsiteRepository {
  final ApiService apiService;

  WebsiteRepository({required this.apiService});

  Future<UniversalData> getWebsites() async => apiService.getWebsites();

  Future<UniversalData> getWebsiteById(int websiteId) async =>
      apiService.getWebsiteById(websiteId);

  Future<UniversalData> createWebsite(WebsiteModel websiteModel) async =>
      apiService.createWebsite(websiteModel: websiteModel);

}