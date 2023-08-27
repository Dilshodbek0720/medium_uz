import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medium_uz/cubits/auth/auth_cubit.dart';
import 'package:medium_uz/cubits/user_data/user_data_cubit.dart';
import 'package:medium_uz/data/models/user/user_field_keys.dart';
import 'package:medium_uz/presentation/auth/widgets/auth_button.dart';
import '../../../data/models/user/user_model.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/images/app_images.dart';
import '../../../utils/ui_utils/error_message_dialog.dart';
import '../../app_routes.dart';
import '../widgets/gender_selector.dart';
import '../widgets/global_button.dart';
import '../widgets/global_text_fields.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(builder: (context, state){
        if (state is AuthLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: [
            SizedBox(height: 50.h),
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
            Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: Text("Username", style: TextStyle(color: AppColors.black),)),
            SizedBox(height: 10.h,),
            GlobalTextField(hintText: "Username", keyboardType: TextInputType.text, textInputAction: TextInputAction.next, textAlign: TextAlign.start, onChanged: (v){
              context.read<UserDataCubit>().updateCurrentUserField(userFieldKeys: UserFieldKeys.username, value: v);
            },),
            SizedBox(height: 22.h,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: Text("Contact", style: TextStyle(color: AppColors.black),)),
            SizedBox(height: 10.h,),
            GlobalTextField(hintText: "Contact", keyboardType: TextInputType.phone, textInputAction: TextInputAction.next, textAlign: TextAlign.start, onChanged: (v){
              context.read<UserDataCubit>().updateCurrentUserField(userFieldKeys: UserFieldKeys.contact, value: v);
            },),
            SizedBox(height: 22.h,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: Text("Gmail", style: TextStyle(color: AppColors.black),)),
            SizedBox(height: 10.h,),
            GlobalTextField(hintText: "Gmail", keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next, textAlign: TextAlign.start, onChanged: (v){
              context.read<UserDataCubit>().updateCurrentUserField(userFieldKeys: UserFieldKeys.email, value: v);
            },),
            SizedBox(height: 22.h,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: Text("Profession", style: TextStyle(color: AppColors.black),)),
            SizedBox(height: 10.h,),
            GlobalTextField(hintText: "Profession", keyboardType: TextInputType.text, textInputAction: TextInputAction.next, textAlign: TextAlign.start, onChanged: (v){
              context.read<UserDataCubit>().updateCurrentUserField(userFieldKeys: UserFieldKeys.profession, value: v);
            },),
            SizedBox(height: 22.h,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 30.w), child: Text("Password", style: TextStyle(color: AppColors.black),)),
            SizedBox(height: 10.h,),
            GlobalTextField(hintText: "Password", keyboardType: TextInputType.visiblePassword, textInputAction: TextInputAction.done, textAlign: TextAlign.start, onChanged: (v){
              context.read<UserDataCubit>().updateCurrentUserField(userFieldKeys: UserFieldKeys.password, value: v);
            },),
            SizedBox(height: 22.h,),
            GenderSelector(),
            TextButton(
                onPressed: () {
                  showBottomSheetDialog();
                },
                child: Text("Select image")),

            GlobalButton(title: "Sign up", onTap: (){
              if(context.read<UserDataCubit>().canRegister()){
                context.read<AuthCubit>().sendCodeToGmail(
                  context.read<UserDataCubit>().state.userModel.email,
                  context
                      .read<UserDataCubit>()
                      .state
                      .userModel
                      .password,
                );
              }else{
                showErrorMessage(message: "Maydonlar to'liq emas", context: context);
              }
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Have an account", style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.black.withOpacity(0.5)
                ),),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
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
            SizedBox(height: 20.h,),
            AuthButton(title: "Connect with Facebook", onTap: (){ }, textColor: AppColors.white, color: AppColors.c_3B5998, icon: AppImages.facebook),
            SizedBox(height: 14.h,),
            AuthButton(title: "Connect with Google", onTap: (){ }, textColor: AppColors.black, color: AppColors.white, icon: AppImages.google),
            SizedBox(height: 40.h,)
          ],
        );
      }, listener: (BuildContext context, AuthState state) {
        if (state is AuthSendCodeSuccessState) {
          Navigator.pushNamed(
            context,
            RouteNames.confirmGmail,
            arguments: context.read<UserDataCubit>().state.userModel,
          );
        }
        if (state is AuthErrorState) {
          showErrorMessage(message: state.errorText, context: context);
        }
      },),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.c_162023,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Select from Camera"),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo),
                title: const Text("Select from Gallery"),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (xFile != null && context.mounted) {
      context.read<UserDataCubit>().updateCurrentUserField(
        userFieldKeys: UserFieldKeys.avatar,
        value: xFile.path,
      );
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null && context.mounted) {
      context.read<UserDataCubit>().updateCurrentUserField(
        userFieldKeys: UserFieldKeys.avatar,
        value: xFile.path,
      );
    }
  }
}