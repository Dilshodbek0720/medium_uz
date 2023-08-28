import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../cubits/website_fetch/website_fetch_cubit.dart';
import '../../../../data/models/status/form_status.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/images/app_images.dart';
import '../../../../utils/ui_utils/error_message_dialog.dart';

class WebsiteDetailScreen extends StatelessWidget {
  const WebsiteDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Website detail"),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.black,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black
        ),
      ),
      body: BlocConsumer<WebsiteFetchCubit, WebsiteFetchState>(
        builder: (context, state) {
          if (state.websiteDetail == null) {
            return const Center(
              child: Text(
                "Loading...",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                ),
              ),
            );
          }
          return Column(
            children: [
              SizedBox(height: 22.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(width: 3, color: Colors.black26)
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: CachedNetworkImage(
                            imageUrl: baseUrl + state.websiteDetail!.image.substring(1),
                            height: 320.r,
                            width: 320.r,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => SizedBox(
                                height: 320.r,
                                width: 320.r,
                                child: Lottie.asset(AppImages.imageLottie)
                            ),
                            errorWidget: (context, url, error) => Container(
                                color: Colors.greenAccent.withOpacity(0.3),
                                child: Icon(Icons.error, color: Colors.black26, size: 70.sp,)),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20.h,
                        right: 12.w,
                        child: SizedBox(
                          height: 30.h, width: 62.w,
                          child: Row(children: [
                            Text(state.websiteDetail!.likes, style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.sp
                            ),),
                            SizedBox(width: 5.w,),
                            Icon(Icons.favorite, color: Colors.red, size: 30.r,)
                          ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 25.h,),
              Container(
                height: 330.h,
                width: 320.w,
                padding: EdgeInsets.all(24.r),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.r), topRight: Radius.circular(22.r)),
                    border: Border.all(width: 3, color: Colors.black26)
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20.h,),
                    Text(
                      state.websiteDetail!.name.substring(0,1).toUpperCase()+state.websiteDetail!.name.substring(1),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Text(
                      "+998 ${state.websiteDetail!.contact.substring(0,2)} ${state.websiteDetail!.contact.substring(2,5)} ${state.websiteDetail!.contact.substring(5,7)} ${state.websiteDetail!.contact.substring(7,9)}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.sp
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Text(
                      "Author: ${state.websiteDetail!.author}",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 24.sp
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Text("Website Link: ",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp
                      ),),
                    TextButton(
                      onPressed: () async{
                        await launchUrlNetwork(state.websiteDetail!.link);
                      },
                      child: Text(
                        state.websiteDetail!.link,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16.sp
                        ),
                      ),
                    ),
                  ],
                ),
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
        },
      ),
    );
  }

  Future<void> launchUrlNetwork(String url) async {
    Uri urlNetwork = Uri.parse(url);
    if (!await launchUrl(urlNetwork)) {
      throw Exception('Could not launch $urlNetwork');
    }
  }
}