import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medium_uz/data/models/universal_data.dart';
import 'package:medium_uz/data/models/user/user_model.dart';
import 'package:medium_uz/data/repositories/profile_repository.dart';
import 'package:medium_uz/services/locator_service.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  getUserData() async{
    emit(ProfileLoadingState());
    UniversalData response = await getIt.get<ProfileRepository>().getUserData();
    if(response.error.isEmpty){
      emit(ProfileSuccessState(userModel: response.data as UserModel));
    } else {
      emit(ProfileErrorState(errorText: response.error));
    }
  }
}
