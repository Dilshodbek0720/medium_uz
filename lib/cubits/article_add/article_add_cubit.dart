import 'package:medium_uz/services/locator_service.dart';
import 'package:medium_uz/utils/export/export.dart';
part 'article_add_state.dart';

class ArticleAddCubit extends Cubit<ArticleAddState> {
  ArticleAddCubit() : super(ArticleAddState(
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

  createArticle(BuildContext context) async{
    emit(state.copyWith(
        status: FormStatus.loading,
        statusText: ""
    ));

    showLoading(context: context);
    UniversalData response = await getIt.get<ArticleRepository>().createArticle(state.articleModel);
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
