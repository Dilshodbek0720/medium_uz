import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medium_uz/cubits/articles/articles_cubit.dart';
import 'package:medium_uz/cubits/articles/articles_state.dart';
import 'package:medium_uz/data/models/articles/articles_model.dart';
import 'package:medium_uz/utils/colors/app_colors.dart';
import 'package:medium_uz/utils/constants/constants.dart';

import '../../../utils/ui_utils/error_message_dialog.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {

  @override
  void initState() {
    context.read<ArticleCubit>().getAllArticles();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Articles screen",),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.c_3669C9,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: BlocConsumer<ArticleCubit, ArticleState>(
        builder: (context, state){
          if(state is ArticleSuccessState){
            return ListView(
              children: [
                ...List.generate(state.articleModels.length, (index) {
                  ArticleModel articleModel = state.articleModels[index];
                  return GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      // height: 300.h,
                      padding: EdgeInsets.all(16.r),
                      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                      decoration: BoxDecoration(
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(borderRadius: BorderRadius.circular(30.r),child: Image.network(baseUrl+articleModel.avatar.substring(1), height: 60.w, width: 60.w,),),
                          SizedBox(width: 12.w,),
                          SizedBox(
                            // height: 250.h,
                            width: 200.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(articleModel.username, style: TextStyle(color: Colors.black, fontSize: 20.sp),),
                                SizedBox(height: 10.h,),
                                Text(articleModel.description, style: TextStyle(color: Colors.black, fontSize: 10.sp), maxLines: 10,)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
                )
              ],
            );
          }
          return const Center(child: CircularProgressIndicator(),);
        },
        listener: (context, state){
          if(state is ArticleLoadingState){
            Center(child: CircularProgressIndicator(),);
          }
          if(state is ArticleErrorState){
            showErrorMessage(message: state.errorText, context: context);
          }
        },
      ),
    );
  }
}