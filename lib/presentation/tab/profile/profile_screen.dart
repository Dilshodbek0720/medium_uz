import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medium_uz/cubits/profile/profile_cubit.dart';
import 'package:medium_uz/utils/ui_utils/custom_circular.dart';
import 'package:medium_uz/utils/ui_utils/error_message_dialog.dart';
import '../../../cubits/auth/auth_cubit.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/constants/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.c_3669C9,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
        toolbarHeight: 64.h,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(MediaQuery.of(context).size.height, 100.0),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).logOut();
              },
              icon: const Icon(Icons.logout)),
          SizedBox(width: 7.w,)
        ],
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        builder: (context, state){
          if(state is ProfileLoadingState){
            return const CustomCircularProgressIndicator();
          }
          if(state is ProfileSuccessState){
            return Column(
              children: [
                SizedBox(height: 12.h,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(110.r),
                    border: Border.all(width: 1, color: Colors.deepPurple),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(110.r),
                    child: Image.network(
                      baseUrl + state.userModel.avatar.substring(1),
                      width: 220.r,
                    ),
                  ),
                ),
                SizedBox(height: 26.h,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  height: 400.h,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 2.r,
                        spreadRadius: 1.r
                      )
                    ],
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30.r), topLeft: Radius.circular(30.r)),
                    color: Colors.deepPurpleAccent.withOpacity(0.1),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 24.h,),
                      Text(
                        state.userModel.username,
                        style: TextStyle(color: Colors.black, fontSize: 30.sp, fontWeight: FontWeight.w600,),
                      ),
                      SizedBox(height: 10.h,),
                      Text(state.userModel.email, style: TextStyle(fontSize: 16.sp, color: Colors.black.withOpacity(0.7)),),
                      SizedBox(height: 10.h,),
                      Text(
                        "Role: ${state.userModel.role}",
                        style: TextStyle(color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.w500, fontSize: 17.sp),
                      ),
                      SizedBox(height: 50.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Contact:", style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.8)),),
                            Text("+998 ${state.userModel.contact.substring(0,2)} ${state.userModel.contact.substring(2,5)} ${state.userModel.contact.substring(5,7)} ${state.userModel.contact.substring(7,9)}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.8)),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Gender:", style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.8)),),
                            Text("${state.userModel.gender.substring(0,1).toUpperCase()}${state.userModel.gender.substring(1)}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.8)),)
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
          return const Text("Error");
        },
        listener: (context, state){
          if(state is ProfileErrorState){
            showErrorMessage(message: state.errorText, context: context);
          }
        },
      ),
    );
  }
}