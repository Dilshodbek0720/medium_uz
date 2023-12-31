import 'package:medium_uz/utils/export/export.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton({Key? key, required this.title, required this.onTap})
      : super(key: key);

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25.w),
        height: 55.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          // color: Color(0xFF4F8962),
          gradient: LinearGradient(
            colors: [
              Color(0xFFFD814A),
              Color(0xFFFC5C4C)
            ]
          )
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.white,
              fontSize: 18.sp,
              fontFamily: "LeagueSpartan",
            ),
          ),
        ),
      ),
    );
  }
}