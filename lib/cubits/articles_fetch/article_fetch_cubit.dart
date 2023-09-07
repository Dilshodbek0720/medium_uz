import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medium_uz/services/locator_service.dart';
import '../../data/models/articles/articles_model.dart';
import '../../data/models/status/form_status.dart';
import '../../data/models/universal_data.dart';
import '../../data/repositories/articles_repository.dart';
import '../../utils/constants/constants.dart';
import '../../utils/ui_utils/loading_dialog.dart';
import 'article_fetch_state.dart';

class ArticleFetchCubit extends Cubit<ArticleFetchState> {
  ArticleFetchCubit() : super(const ArticleFetchState(articles: []));


  getArticles(BuildContext context) async{
    emit(state.copyWith(
      status: FormStatus.loading,
      statusText: "",
    ));
    showLoading(context: context);
    UniversalData response = await getIt.get<ArticleRepository>().getAllArticles();
    if(context.mounted){
      debugPrint("Hiring...");
      hideLoading(dialogContext: context);
    }
    if(response.error.isEmpty){
      emit(state.copyWith(
        status: FormStatus.success,
        statusText: StatusTextConstants.gotAllWebsite,
        articles: response.data as List<ArticleModel>,
      ),);
    }else{
      emit(state.copyWith(
        status: FormStatus.failure,
        statusText: response.error,
      ));
    }
  }

  getArticleById(int articleId) async {
    emit(state.copyWith(
      status: FormStatus.loading,
      statusText: "",
    ));
    UniversalData response = await getIt.get<ArticleRepository>().getArticleById(articleId);
    if (response.error.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.success,
          statusText: StatusTextConstants.gotWebsiteById,
          articleDetail: response.data as ArticleModel,
        ),
      );
    } else {
      emit(state.copyWith(
        status: FormStatus.failure,
        statusText: response.error,
      ));
    }
  }
}