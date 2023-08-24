part of 'user_data_cubit.dart';

class UserDataState {
  final String errorText;
  final UserModel userModel;

  UserDataState({
    required this.errorText,
    required this.userModel,
  });

  UserDataState copyWith({
    String? errorText,
    UserModel? userModel,
  }) =>
      UserDataState(
        errorText: errorText ?? this.errorText,
        userModel: userModel ?? this.userModel,
      );
}
