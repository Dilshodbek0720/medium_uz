import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import '../../../cubits/auth/auth_cubit.dart';
import '../../../cubits/profile/profile_cubit.dart';
import '../../../cubits/user_data/user_data_cubit.dart';
import '../../../data/models/user/user_model.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/ui_utils/error_message_dialog.dart';
import '../../app_routes.dart';
import '../widgets/global_button.dart';


class GmailConfirmScreen extends StatefulWidget {
  GmailConfirmScreen({super.key, required this.userModel});
  UserModel userModel;

  @override
  State<GmailConfirmScreen> createState() => _GmailConfirmScreenState();
}

class _GmailConfirmScreenState extends State<GmailConfirmScreen> {

  final focusNode = FocusNode();

  final TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Colors.blue;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Colors.black;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gmail Confirm Screen"),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.c_3669C9,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Directionality(
                // Specify direction if desired
                textDirection: TextDirection.ltr,
                child: Pinput(
                  length: 6,
                  controller: pinController,
                  focusNode: focusNode,
                  androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsUserConsentApi,
                  listenForMultipleSmsOnAndroid: true,
                  defaultPinTheme: defaultPinTheme,
                  separatorBuilder: (index) => const SizedBox(width: 8),
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (pin) {
                    debugPrint('onCompleted: $pin');
                  },
                  onChanged: (value) {
                    debugPrint('onChanged: $value');
                  },
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        width: 22,
                        height: 1,
                        color: focusedBorderColor,
                      ),
                    ],
                  ),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(19),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color: Colors.redAccent),
                  ),
                ),
              ),
              SizedBox(height: 40.h,),
              GlobalButton(
                title: "Next",
                onTap: () {
                  context.read<AuthCubit>().confirmGmail(pinController.text);
                },
              ),
              const SizedBox(height: 50)
            ],
          );
        },
        listener: (context, state) {
          if (state is AuthConfirmCodeSuccessState) {
            context.read<AuthCubit>().registerUser(widget.userModel);
          }

          if (state is AuthLoggedState) {
            context.read<UserDataCubit>().clearData();
            BlocProvider.of<ProfileCubit>(context).getUserData();
            Navigator.pushReplacementNamed(context, RouteNames.tabBox);
          }

          if (state is AuthErrorState) {
            showErrorMessage(message: state.errorText, context: context);
          }
        },
      ),
    );
  }
}