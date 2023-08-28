import 'package:medium_uz/utils/export/export.dart';
import 'package:flutter/cupertino.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({super.key});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Article detail"),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.black,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black
        ),
      ),
      body: BlocConsumer<ArticleFetchCubit, ArticleFetchState>(
        builder: (context, state) {
          if (state.articleDetail == null) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 50.w,),
                  CachedNetworkImage(
                    imageUrl: baseUrl + state.articleDetail!.avatar.substring(1),
                    height: 120.r,
                    width: 120.r,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => SizedBox(
                        height: 120.r,
                        width: 120.r,
                        child: Lottie.asset(AppImages.imageLottie)
                    ),
                    errorWidget: (context, url, error) => Container(
                        color: Colors.greenAccent.withOpacity(0.3),
                        child: Icon(Icons.error, color: Colors.black26, size: 50.sp,)),
                  ),
                  SizedBox(width: 40.w,),
                  Text(
                    state.articleDetail!.username,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.sp
                    ),
                  ),
                ],),
                SizedBox(height: 10.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(state.articleDetail!.title, maxLines: 2, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 22.sp, color: Colors.black),),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                  padding: EdgeInsets.all(10.r),
                  decoration:BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 2,
                        blurRadius: 2,
                      )
                    ],
                    border: Border.all(width: 1, color: Colors.black26),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        state.articleDetail!.description,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 6.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(state.articleDetail!.profession.substring(0,1).toUpperCase()+state.articleDetail!.profession.substring(1), style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic, fontSize: 16.sp),),
                          const Spacer(),
                        Text(state.articleDetail!.views, style: TextStyle(color: Colors.black),),
                        SizedBox(width: 3.w,),
                        Icon(Icons.visibility, size: 18.r,),
                          SizedBox(width: 6.w,)
                      ],)
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state.status == FormStatus.failure) {
            showErrorMessage(
              message: state.statusText,
              context: context,
            );
          }
        },
      ),
    );
  }
}
