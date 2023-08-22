import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../cubits/auth/auth_cubit.dart';
import '../../widgets/global_text_fields.dart';

class EmailPasswordInput extends StatelessWidget {
  const EmailPasswordInput(
      {super.key,
        required this.gmailController,
        required this.passwordController});

  final TextEditingController gmailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      if (state is AuthLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Column(
        children: [
          SizedBox(height: 10.h,),
          GlobalTextField(
            hintText: "Gmail",
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.start,
            controller: gmailController,
          ),
          SizedBox(height: 10.h,),
          GlobalTextField(
            hintText: "Password",
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            textAlign: TextAlign.start,
            controller: passwordController,
          )
        ],
      );
    });
  }
}