import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:medium_uz/cubits/website_fetch/website_fetch_cubit.dart';
import 'package:medium_uz/data/models/status/form_status.dart';
import 'package:medium_uz/presentation/tab/widgets/custom_appbar.dart';
import 'package:medium_uz/utils/constants/constants.dart';
import 'package:medium_uz/utils/ui_utils/error_message_dialog.dart';
import '../../../data/models/websites/website_model.dart';
import '../../../utils/images/app_images.dart';
import '../../app_routes.dart';

class WebsitesScreen extends StatefulWidget {
  const WebsitesScreen({super.key});

  @override
  State<WebsitesScreen> createState() => _WebsitesScreenState();
}

class _WebsitesScreenState extends State<WebsitesScreen> {

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async{
    Future.microtask(() => BlocProvider.of<WebsiteFetchCubit>(context).getWebsites(context));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Websites Screen",
        onTap: () {
          Navigator.pushNamed(context, RouteNames.addWebsite);
        },
        icon: const Icon(Icons.add),
      ),
        body: BlocConsumer<WebsiteFetchCubit, WebsiteFetchState>(
          builder: (context, state) {
            return ListView(
              children: [
                ...List.generate(state.websites.length, (index) {
                  WebsiteModel website = state.websites[index];
                  return ListTile(
                    onTap: () {
                      context
                          .read<WebsiteFetchCubit>()
                          .getWebsiteById(website.id);
                      Navigator.pushNamed(context, RouteNames.websiteDetail);
                    },
                    title: Text(
                      website.name,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(website.link),
                    trailing: CachedNetworkImage(
                      imageUrl: baseUrl+website.image.substring(1),
                      height: 45.r,
                      width: 45.r,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => SizedBox(
                          height: 22.r,
                          width: 22.r,
                          child: Lottie.asset(AppImages.imageLottie)
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  );
                }),
              ],
            );
          },
        listener: (context, state){
          if(state.status == FormStatus.failure){
            showErrorMessage(message: state.statusText, context: context);
          }
        },
      )
    );
  }
}
