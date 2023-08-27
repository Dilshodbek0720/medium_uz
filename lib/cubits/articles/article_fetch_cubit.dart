import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/articles/articles_model.dart';
import '../../data/models/universal_data.dart';
import '../../data/repositories/articles_repository.dart';
import 'article_fetch_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit({required this.articleRepository}) : super(ArticleInitial());

  final ArticleRepository articleRepository;



  Future<void> getAllArticles() async {
    emit(ArticleLoadingState());
    UniversalData universalData = await articleRepository.getAllArticles();
    if (universalData.error.isEmpty) {
      print("afsdfjhgfa: ${universalData.data}");
      emit(ArticleSuccessState(articleModels: universalData.data as List<ArticleModel>));
    } else {
      emit(ArticleErrorState(errorText: universalData.error));
    }
  }
}