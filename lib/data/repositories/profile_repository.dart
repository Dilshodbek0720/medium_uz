import 'package:medium_uz/data/network/api_service.dart';
import 'package:medium_uz/data/network/secure_api_service.dart';
import '../../services/locator_service.dart';
import '../models/universal_data.dart';
import '../network/open_api_service.dart';

class ProfileRepository {

  Future<UniversalData> getUserData() async => getIt.get<SecureApiService>().getProfileData();
}