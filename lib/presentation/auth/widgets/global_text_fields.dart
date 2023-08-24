import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/colors/app_colors.dart';

class GlobalTextField extends StatelessWidget {
  GlobalTextField({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    required this.textInputAction,
    required this.textAlign,
    this.obscureText = false,
    this.maxLine = 1,
    required this.onChanged,
  }) : super(key: key);

  final String hintText;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  TextAlign textAlign;
  final bool obscureText;
  final int maxLine;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 2.r,
              offset: const Offset(0, 0),
            )
          ]
      ),
      child: TextField(
        cursorColor: Color(0xFF4F8962),
        maxLines: maxLine,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.c_0C1A30,
            fontFamily: "DMSans"),
        textAlign: textAlign,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.c_0C1A30.withOpacity(0.5),
              fontFamily: "DMSans"),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: AppColors.white),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 1,
              color: AppColors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: AppColors.white,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: AppColors.white,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}