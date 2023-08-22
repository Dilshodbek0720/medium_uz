import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medium_uz/presentation/auth/pages/widgets/auth_button.dart';

import '../../../utils/colors/app_colors.dart';
import '../../../utils/images/app_images.dart';
import '../../app_routes.dart';
import '../widgets/global_button.dart';
import '../widgets/global_text_fields.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, required this.onChanged});

  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
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
        GlobalTextField(hintText: "E-mail", keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next, textAlign: TextAlign.start, controller: TextEditingController()),
        SizedBox(height: 22.h,),
        Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: Text("Password", style: TextStyle(color: AppColors.black),)),
        SizedBox(height: 10.h,),
        GlobalTextField(hintText: "Password", keyboardType: TextInputType.visiblePassword, textInputAction: TextInputAction.done, textAlign: TextAlign.start, controller: TextEditingController()),
        SizedBox(height: 50.h,),
        GlobalButton(title: "Sign up", onTap: (){ }),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Have an account", style: TextStyle(
                fontSize: 15.sp,
                color: AppColors.black.withOpacity(0.5)
            ),),
            TextButton(
              onPressed: () {
                onChanged.call();
              },
              child: Text(
                "Login",
                style: TextStyle(
                    color: Color(0xFF4F8962),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.confirmGmail);
          },
          child: Text(
            "First Confirm your",
            style: TextStyle(
                color: AppColors.c_2B2B2B,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 20.h,),
        AuthButton(title: "Connect with Facebook", onTap: (){ }, textColor: AppColors.white, color: AppColors.c_3B5998, icon: AppImages.facebook),
        SizedBox(height: 14.h,),
        AuthButton(title: "Connect with Google", onTap: (){ }, textColor: AppColors.black, color: AppColors.white, icon: AppImages.google),
      ],
    );
  }
}