import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medium_uz/data/models/articles/article_field_keys.dart';
import 'package:medium_uz/data/models/articles/articles_model.dart';
import 'package:medium_uz/data/repositories/articles_repository.dart';
import 'package:medium_uz/utils/constants/constants.dart';
import '../../data/models/status/form_status.dart';
import '../../data/models/universal_data.dart';
import '../../utils/ui_utils/loading_dialog.dart';

part 'article_add_state.dart';

class ArticleAddCubit extends Cubit<ArticleAddState> {
  ArticleAddCubit({required this.articleRepository}) : super(ArticleAddState(
    articleModel: ArticleModel(
      likes: "",
      image: "",
      addDate: "",
      artId: 0,
      avatar: "",
      description: "",
      profession: "",
      title: "",
      userId: 0,
      username: "",
      views: ""
    )
  ));

  final ArticleRepository articleRepository;

  createArticle(BuildContext context) async{
    emit(state.copyWith(
        status: FormStatus.loading,
        statusText: ""
    ));

    showLoading(context: context);
    UniversalData response = await articleRepository.createArticle(state.articleModel);
    if(context.mounted) hideLoading(dialogContext: context);

    if(response.error.isEmpty){
      emit(state.copyWith(
        status: FormStatus.success,
        statusText: StatusTextArticlesConstants.articleAdd,
      ),);
    }else{
      emit(state.copyWith(
        status: FormStatus.failure,
        statusText: response.error,
      ));
    }
  }

  updateArticleField({
    required ArticleFieldKeys fieldKey,
    required dynamic value,
  }) {
    ArticleModel currentArticle = state.articleModel;

    switch (fieldKey) {
      case ArticleFieldKeys.image:
        {
          currentArticle = currentArticle.copyWith(image: value as String);
          break;
        }
      case ArticleFieldKeys.title:
        {
          currentArticle = currentArticle.copyWith(title: value as String);
          break;
        }
      case ArticleFieldKeys.description:
        {
          currentArticle = currentArticle.copyWith(description: value as String);
          break;
        }
      case ArticleFieldKeys.profession: {
        currentArticle = currentArticle.copyWith(profession: value as String);
        break;
      }
      case ArticleFieldKeys.addDate: {
        currentArticle = currentArticle.copyWith(addDate: value as String);
        break;
      }
      case ArticleFieldKeys.avatar: {
        currentArticle = currentArticle.copyWith(avatar: value as String);
        break;
      }
      case ArticleFieldKeys.views: {
        currentArticle = currentArticle.copyWith(views: value as String);
        break;
      }
      case ArticleFieldKeys.likes: {
        currentArticle = currentArticle.copyWith(likes: value as String);
        break;
      }
      case ArticleFieldKeys.userId: {
        currentArticle = currentArticle.copyWith(userId: value as int);
        break;
      }
      case ArticleFieldKeys.username: {
        currentArticle = currentArticle.copyWith(username: value as String);
        break;
      }
    }

    debugPrint("Article: ${currentArticle.toString()}");

    emit(state.copyWith(
      articleModel: currentArticle,
      status: FormStatus.pure,
    ));
  }
}
