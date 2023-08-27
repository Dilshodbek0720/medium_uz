import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medium_uz/cubits/articles/article_fetch_cubit.dart';
import 'package:medium_uz/cubits/articles/article_fetch_state.dart';
import 'package:medium_uz/data/models/articles/articles_model.dart';
import 'package:medium_uz/utils/colors/app_colors.dart';
import 'package:medium_uz/utils/constants/constants.dart';

import '../../../data/models/status/form_status.dart';
import '../../../utils/ui_utils/error_message_dialog.dart';
import '../../app_routes.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async{
    Future.microtask(() => BlocProvider.of<ArticleFetchCubit>(context).getArticles(context));
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
        toolbarHeight: 64.h,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(MediaQuery.of(context).size.height, 100.0),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
          SizedBox(width: 7.w,)
        ],
      ),
      body: BlocConsumer<ArticleFetchCubit, ArticleFetchState>(
        builder: (context, state){
          return ListView(
            children: [
              ...List.generate(state.articles.length, (index) {
                ArticleModel articleModel = state.articles[index];
                return GestureDetector(
                  onTap: (){
                    debugPrint(articleModel.artId.toString());
                    context
                        .read<ArticleFetchCubit>()
                        .getArticleById(articleModel.artId);
                    Navigator.pushNamed(context, RouteNames.articleDetail);
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
        },
        listener: (context, state){
          if(state.status == FormStatus.failure){
            showErrorMessage(message: state.statusText, context: context);
          }
        },
      ),
    );
  }
}