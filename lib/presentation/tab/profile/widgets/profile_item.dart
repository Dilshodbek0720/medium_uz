import 'package:medium_uz/utils/export/export.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({super.key, required this.icon, required this.text1, required this.text2, required this.onTap});
  final Icon icon;
  final String text1;
  final String text2;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70.h,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26.withOpacity(0.15),
                  blurRadius: 20,
                  spreadRadius: 0
              )
            ]
        ),
        child: Row(
          children: [
            SizedBox(width: 10.w,),
            icon,
            SizedBox(width: 10.w,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text1, style: TextStyle(fontSize: 16.sp, color: Colors.black87, fontWeight: FontWeight.w500),),
                SizedBox(height: 4.h,),
                Text(text2, style: TextStyle(fontSize: 14.sp, color: Colors.black54, fontWeight: FontWeight.w500),)
              ],
            )
          ],
        ),
      ),
    );
  }
}