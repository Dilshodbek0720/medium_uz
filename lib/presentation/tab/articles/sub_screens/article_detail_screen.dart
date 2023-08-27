import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medium_uz/cubits/articles/article_fetch_cubit.dart';
import 'package:medium_uz/cubits/articles/article_fetch_state.dart';
import '../../../../data/models/status/form_status.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/ui_utils/error_message_dialog.dart';

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
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.c_3669C9,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: BlocConsumer<ArticleFetchCubit, ArticleFetchState>(
        builder: (context, state) {
          if (state.articleDetail == null) {
            return const Center(
              child: Text(
                "Loading...",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                // Image.network(
                //   baseUrl + state.articleDetail!.avatar.substring(1),
                //   width: 300,
                // ),
                // Text(
                //   state.articleDetail!.avatar,
                //   style: const TextStyle(
                //     color: Colors.black,
                //   ),
                // ),
                Text(
                  state.articleDetail!.username,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  state.articleDetail!.description,
                  style: const TextStyle(
                    color: Colors.black,
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
