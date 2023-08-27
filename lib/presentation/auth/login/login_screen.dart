import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medium_uz/cubits/auth/auth_cubit.dart';
import 'package:medium_uz/presentation/auth/widgets/auth_button.dart';
import 'package:medium_uz/presentation/auth/widgets/global_button.dart';
import 'package:medium_uz/presentation/auth/widgets/global_text_fields.dart';
import 'package:medium_uz/utils/colors/app_colors.dart';
import 'package:medium_uz/utils/images/app_images.dart';

import '../../../utils/ui_utils/error_message_dialog.dart';
import '../../app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String gmail = "";
  String password = "";


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, state){
            if (state is AuthLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: [
                SizedBox(height: 70.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text("Let’s start here", style: TextStyle(
                    color: AppColors.c_2B2B2B,
                    fontSize: 34.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Sora",
                  ),),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text("Fill in your details to begin", style: TextStyle(
                    color: AppColors.c_7A7A7A,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Sora",
                  ),),
                ),
                SizedBox(height: 40.h,),
                Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: Text("Email", style: TextStyle(color: AppColors.black),)),
                SizedBox(height: 10.h,),
                GlobalTextField(hintText: "E-mail", keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next, textAlign: TextAlign.start, onChanged: (v){
                  gmail = v;
                },),
                SizedBox(height: 22.h,),
                Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: Text("Password", style: TextStyle(color: AppColors.black),)),
                SizedBox(height: 10.h,),
                GlobalTextField(hintText: "Password", keyboardType: TextInputType.visiblePassword, textInputAction: TextInputAction.done, textAlign: TextAlign.start, onChanged: (v){
                  password = v;
                },),
                SizedBox(height: 50.h,),
                GlobalButton(title: "Login up", onTap: (){
                  context.read<AuthCubit>().loginUser(
                    gmail: gmail,
                    password: password,
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account", style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.black.withOpacity(0.5)
                    ),),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RouteNames.registerScreen);
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Color(0xFF4F8962),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h,),
                AuthButton(title: "Connect with Facebook", onTap: (){ }, textColor: AppColors.white, color: AppColors.c_3B5998, icon: AppImages.facebook),
                SizedBox(height: 14.h,),
                AuthButton(title: "Connect with Google", onTap: (){ }, textColor: AppColors.black, color: AppColors.white, icon: AppImages.google),
              ],
            );
          },
          listener: (BuildContext context, AuthState state) {
            if (state is AuthLoggedState) {
              Navigator.pushReplacementNamed(context, RouteNames.tabBox);
            }

            if (state is AuthErrorState) {
              showErrorMessage(message: state.errorText, context: context);
            }
          },
        ),
      ),
    );
  }
}