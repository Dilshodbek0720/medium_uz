import '../../data/models/articles/articles_model.dart';

abstract class ArticleState {}

class ArticleInitial extends ArticleState {}

class ArticleLoadingState extends ArticleState {}

class ArticleSuccessState extends ArticleState {
  ArticleSuccessState({required this.articleModels});
  List<ArticleModel> articleModels;

}

class ArticleErrorState extends ArticleState {
  final String errorText;

  ArticleErrorState({required this.errorText});
}