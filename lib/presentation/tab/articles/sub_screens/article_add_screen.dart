import 'package:medium_uz/utils/export/export.dart';
import '../../../auth/widgets/global_button.dart';
import '../../../auth/widgets/global_text_fields.dart';

class ArticleAddScreen extends StatefulWidget {
  const ArticleAddScreen({super.key});

  @override
  State<ArticleAddScreen> createState() => _ArticleAddScreenState();
}

class _ArticleAddScreenState extends State<ArticleAddScreen> {
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Article "),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColors.black,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black
        ),
      ),
      body: BlocConsumer<ArticleAddCubit, ArticleAddState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Add Article",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 16.h,),
              GlobalTextField(
                hintText: "TITLE",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                onChanged: (v) {
                  context.read<ArticleAddCubit>().updateArticleField(
                    fieldKey: ArticleFieldKeys.title,
                    value: v,
                  );
                },
              ),
              SizedBox(height: 20.h,),
              GlobalTextField(
                hintText: "DESCRIPTION",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                onChanged: (v) {
                  context.read<ArticleAddCubit>().updateArticleField(
                    fieldKey: ArticleFieldKeys.description,
                    value: v,
                  );
                },
              ),
              SizedBox(height: 20.h,),
              TextButton(
                onPressed: () {
                  showBottomSheetDialog();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Select Image"), Icon(Icons.image)],
                ),
              ),
              SizedBox(height: 20.h,),
              GlobalButton(
                title: "Add Article",
                onTap: () {
                  if (context.read<ArticleAddCubit>().state.canAddArticle()) {
                    context.read<ArticleAddCubit>().createArticle(context);
                  } else {
                    showErrorMessage(
                        message: "Ma'lumotlar to'liq emas!!!",
                        context: context);
                  }
                },
              )
            ],
          );
        },
        listener: (context, state) {
          if (state.status == FormStatus.failure) {
            showErrorMessage(
              message: state.statusText,
              context: context,
            );
          }

          if (state.status == FormStatus.success &&
              state.statusText == StatusTextArticlesConstants.articleAdd) {
            BlocProvider.of<ArticleFetchCubit>(context).getArticles(context);
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.c_162023,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Select from Camera"),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo),
                title: const Text("Select from Gallery"),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (xFile != null && context.mounted) {
      BlocProvider.of<ArticleAddCubit>(context).updateArticleField(
        fieldKey: ArticleFieldKeys.image,
        value: xFile.path,
      );
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null && context.mounted) {
      BlocProvider.of<ArticleAddCubit>(context).updateArticleField(
        fieldKey: ArticleFieldKeys.image,
        value: xFile.path,
      );
    }
  }
}
