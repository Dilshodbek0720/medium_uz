import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medium_uz/data/models/articles/articles_model.dart';
import 'package:medium_uz/main.dart';

class ShowDetailScreen extends StatefulWidget {
  const ShowDetailScreen({super.key, required this.articleModel});
  final ArticleModel articleModel;

  @override
  State<ShowDetailScreen> createState() => _ShowDetailScreenState();
}

class _ShowDetailScreenState extends State<ShowDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Detail Screen"),
      ),
      body: Column(
        children: [
          SizedBox(height: 30.h,),
          SizedBox(height: 250.w, width: 250.w, child: Image.asset(widget.articleModel.avatar),),
          SizedBox(height: 20.h,),
          Text(widget.articleModel.username, style: TextStyle(
            fontSize: 24.sp
          ),),
        ],
      ),
    );
  }
}
