import 'package:medium_uz/utils/export/export.dart';


class AuthButton extends StatelessWidget {
  const AuthButton({Key? key, required this.title, required this.onTap, required this.textColor, required this.color, required this.icon})
      : super(key: key);

  final String title;
  final VoidCallback onTap;
  final Color textColor;
  final Color color;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25.w),
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          border: Border.all(width: 1, color: AppColors.c_3B5998),
          color: color,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 24.w, width: 24.w,child: SvgPicture.asset(icon),),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: textColor,
                  fontSize: 18.sp,
                  fontFamily: "LeagueSpartan",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}