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
                  return Stack(
                    children: [
                      Container(
                        height: 120.h,
                        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 3,
                                  blurRadius: 3
                              )
                            ],
                            borderRadius: BorderRadius.circular(16.r),
                            color: Colors.white
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                          onTap: () {
                            context
                                .read<WebsiteFetchCubit>()
                                .getWebsiteById(website.id);
                            Navigator.pushNamed(context, RouteNames.websiteDetail);
                          },
                          title: Text(
                            website.name.substring(0,1).toUpperCase()+website.name.substring(1),
                            style: TextStyle(
                              fontSize: 22.sp,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(website.link,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),),
                              Text(website.author,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),),
                              SizedBox(height: 10.h,)
                            ],
                          ),
                          trailing: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: CachedNetworkImage(
                              imageUrl: baseUrl+website.image.substring(1),
                              height: 70.r,
                              width: 70.r,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => SizedBox(
                                  height: 32.r,
                                  width: 32.r,
                                  child: Lottie.asset(AppImages.imageLottie)
                              ),
                              errorWidget: (context, url, error) => Icon(Icons.error, size: 30.r,),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20.h,
                        right: 32.w,
                          child: SizedBox(
                            height: 20.h, width: 42.w,
                            child: Row(children: [
                              Text(website.likes, style: const TextStyle(
                                color: Colors.black
                              ),),
                              SizedBox(width: 5.w,),
                              const Icon(Icons.favorite, color: Colors.red, size: 16,)
                            ],),
                          ),
                      )
                    ],
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
