part of 'article_add_cubit.dart';

class ArticleAddState extends Equatable{
  final String statusText;
  final ArticleModel articleModel;
  final FormStatus status;

  const ArticleAddState({
    required this.articleModel,
    this.statusText = "",
    this.status = FormStatus.pure,
  });

  ArticleAddState copyWith({
    String? statusText,
    ArticleModel? articleModel,
    FormStatus? status,
  }) => ArticleAddState(
    articleModel: articleModel ?? this.articleModel,
    statusText: statusText ?? this.statusText,
    status: status ?? this.status,
  );

  @override
  List<Object?> get props => [
    articleModel,
    statusText,
    status,
  ];

  bool canAddArticle() {
    if (articleModel.image.isEmpty) return false;
    if (articleModel.title.isEmpty) return false;
    if (articleModel.description.isEmpty) return false;
    return true;
  }
}

