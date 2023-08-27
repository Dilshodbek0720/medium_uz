import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/colors/app_colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppbar({super.key, required this.title, required this.onTap, required this.icon});
  final String title;
  final VoidCallback onTap;
  final Icon icon;

  @override
  Widget build(BuildContext context){
    return AppBar(
      title: Text(title),
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
        Padding(
          padding: EdgeInsets.only(bottom: 6.h),
          child: IconButton(
            onPressed: onTap,
            icon: icon,
          ),
        ),
        SizedBox(width: 6.w,)
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 62);
}
