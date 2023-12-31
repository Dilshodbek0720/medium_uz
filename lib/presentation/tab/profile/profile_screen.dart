import 'package:medium_uz/utils/export/export.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Profile Screen",
        onTap: () {
          BlocProvider.of<AuthCubit>(context).logOut();
        },
        icon: const Icon(Icons.logout),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        builder: (context, state){
          if(state is ProfileLoadingState){
            return const CustomCircularProgressIndicator();
          }
          if(state is ProfileSuccessState){
            return Column(
              children: [
                SizedBox(height: 24.h,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(110.r),
                    border: Border.all(width: 1, color: Colors.deepPurple),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(110.r),
                    child: CachedNetworkImage(
                      height: 220.r,
                      width: 220.r,
                      imageUrl: baseUrl + state.userModel.avatar.substring(1),
                      placeholder: (context, url) => SizedBox(
                        height: 220.r,
                          width: 220.r,
                          child: Lottie.asset(AppImages.profileLottie)
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    )
                  ),
                ),
                SizedBox(height: 26.h,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  height: 385.h,
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
                      SizedBox(height: 6.h,),
                      Text(state.userModel.email, style: TextStyle(fontSize: 16.sp, color: Colors.black.withOpacity(0.7)),),
                      SizedBox(height: 6.h,),
                      Text(
                        "Role: ${state.userModel.role}",
                        style: TextStyle(color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.w500, fontSize: 17.sp),
                      ),
                      SizedBox(height: 10.h,),
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
                      SizedBox(height: 14.h,),
                      ProfileItem(icon: Icon(Icons.settings, color: Colors.green,size: 32.sp,), text1: "Settings", text2: "Change your setting", onTap: (){}),
                      SizedBox(height: 12.h,),
                      ProfileItem(icon: Icon(Icons.info, color: Colors.green,size: 32.sp,), text1: "FAQ", text2: "Consult the online help", onTap: (){}),
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