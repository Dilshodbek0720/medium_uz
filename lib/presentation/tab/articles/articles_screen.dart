import 'package:medium_uz/utils/export/export.dart';


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
      appBar: CustomAppbar(title: 'Articles Screen',onTap: (){
        Navigator.pushNamed(context, RouteNames.addArticle);
      }, icon: const Icon(Icons.add)),
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
                        ClipRRect(borderRadius: BorderRadius.circular(30.r),child:
                        CachedNetworkImage(
                          imageUrl: baseUrl+articleModel.avatar.substring(1),
                          height: 60.r,
                          width: 60.r,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => SizedBox(
                              height: 60.r,
                              width: 60.r,
                              child: Lottie.asset(AppImages.imageLottie)
                          ),
                          errorWidget: (context, url, error) => Container(
                              color: Colors.greenAccent.withOpacity(0.3),
                              child: Icon(Icons.error, color: Colors.black26, size: 30.sp,)),
                        ),
                        ),
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