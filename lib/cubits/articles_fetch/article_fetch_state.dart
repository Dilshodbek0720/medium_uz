import 'package:equatable/equatable.dart';
import 'package:medium_uz/data/models/articles/articles_model.dart';
import '../../data/models/status/form_status.dart';

class ArticleFetchState extends Equatable{
  final String statusText;
  final ArticleModel? articleDetail;
  final List<ArticleModel> articles;
  final FormStatus status;

  const ArticleFetchState({
    this.articleDetail,
    this.statusText = "",
    this.status = FormStatus.pure,
    required this.articles,
  });

  ArticleFetchState copyWith({
    String? statusText,
    ArticleModel? articleDetail,
    List<ArticleModel>? articles,
    FormStatus? status,
  }) => ArticleFetchState(
    articleDetail: articleDetail ?? this.articleDetail,
    articles: articles ?? this.articles,
    statusText: statusText ?? this.statusText,
    status: status ?? this.status,
  );

  @override
  List<Object?> get props => [
    articles,
    statusText,
    status,
    articleDetail,
  ];
}