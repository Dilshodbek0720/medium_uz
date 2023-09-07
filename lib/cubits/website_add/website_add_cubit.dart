import 'package:medium_uz/services/locator_service.dart';
import 'package:medium_uz/utils/export/export.dart';
part 'website_add_state.dart';

class WebsiteAddCubit extends Cubit<WebsiteAddState> {
  WebsiteAddCubit() : super(
    WebsiteAddState(websiteModel: WebsiteModel(
      name: "",
      image: "",
      author: "",
      hashtag: "",
      contact: "",
      likes: "",
      link: "",
    ),),
  );

  createWebsite(BuildContext context) async{
    emit(state.copyWith(
      status: FormStatus.loading,
      statusText: ""
    ));
    
    showLoading(context: context);
    UniversalData response = await getIt.get<WebsiteRepository>().createWebsite(state.websiteModel);
    if(context.mounted) hideLoading(dialogContext: context);

    if(response.error.isEmpty){
      emit(state.copyWith(
        status: FormStatus.success,
        statusText: StatusTextConstants.websiteAdd,
      ),);
    }else{
      emit(state.copyWith(
        status: FormStatus.failure,
        statusText: response.error,
      ));
    }
  }

  updateWebsiteField({
    required WebsiteFieldKeys fieldKey,
    required dynamic value,
  }) {
    WebsiteModel currentWebsite = state.websiteModel;

    switch (fieldKey) {
      case WebsiteFieldKeys.hashtag:
        {
          currentWebsite = currentWebsite.copyWith(hashtag: value as String);
          break;
        }
      case WebsiteFieldKeys.contact:
        {
          currentWebsite = currentWebsite.copyWith(contact: value as String);
          break;
        }
      case WebsiteFieldKeys.link:
        {
          currentWebsite = currentWebsite.copyWith(link: value as String);
          break;
        }
      case WebsiteFieldKeys.author:
        {
          currentWebsite = currentWebsite.copyWith(author: value as String);
          break;
        }
      case WebsiteFieldKeys.name:
        {
          currentWebsite = currentWebsite.copyWith(name: value as String);
          break;
        }
      case WebsiteFieldKeys.image:
        {
          currentWebsite = currentWebsite.copyWith(image: value as String);
          break;
        }
      case WebsiteFieldKeys.likes:
        {
          currentWebsite = currentWebsite.copyWith(likes: value as String);
          break;
        }
    }

    debugPrint("WEBSITE: ${currentWebsite.toString()}");

    emit(state.copyWith(
      websiteModel: currentWebsite,
      status: FormStatus.pure,
    ));
  }
}
