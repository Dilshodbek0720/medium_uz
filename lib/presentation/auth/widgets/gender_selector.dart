import 'package:medium_uz/utils/export/export.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    String gender =   context.watch<UserDataCubit>().state.userModel.gender;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
              backgroundColor:
              gender == "male" ? AppColors.c_3669C9 : AppColors.white),
          onPressed: (){
            context.read<UserDataCubit>().updateCurrentUserField(
              userFieldKeys: UserFieldKeys.gender,
              value: "male",
            );
          },
          child: Text(
            "MALE",
            style: TextStyle(
                color: gender == "male" ? AppColors.white : AppColors.black),
          ),
        ),
        TextButton(
            style: TextButton.styleFrom(
                backgroundColor:
                gender == "female" ? AppColors.c_3669C9 : AppColors.white),
            onPressed: (){
              context.read<UserDataCubit>().updateCurrentUserField(
                userFieldKeys: UserFieldKeys.gender,
                value: "female",
              );
            },
            child: Text(
              "FEMALE",
              style: TextStyle(
                  color: gender == "female" ? AppColors.white : AppColors.black),
            )),
      ],
    );
  }
}