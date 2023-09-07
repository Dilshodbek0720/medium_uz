import 'package:medium_uz/data/models/websites/website_model.dart';
import 'package:medium_uz/data/network/secure_api_service.dart';
import '../../services/locator_service.dart';
import '../models/universal_data.dart';
import '../network/open_api_service.dart';

class WebsiteRepository {

  Future<UniversalData> getWebsites() async => getIt.get<OpenApiService>().getWebsites();

  Future<UniversalData> getWebsiteById(int websiteId) async =>
      getIt.get<OpenApiService>().getWebsiteById(websiteId);

  Future<UniversalData> createWebsite(WebsiteModel websiteModel) async =>
      getIt.get<SecureApiService>().createWebsite(websiteModel: websiteModel);

}