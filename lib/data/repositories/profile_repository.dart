import 'package:medium_uz/data/network/secure_api_service.dart';
import '../../services/locator_service.dart';
import '../models/universal_data.dart';

class ProfileRepository {

  Future<UniversalData> getUserData() async => getIt.get<SecureApiService>().getProfileData();
}