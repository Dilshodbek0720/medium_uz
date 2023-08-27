import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
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
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.c_3669C9,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
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
          return SingleChildScrollView(
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: baseUrl + state.websiteDetail!.image.substring(1),
                  height: 300.r,
                  width: 300.r,
                  placeholder: (context, url) => SizedBox(
                      height: 300.r,
                      width: 300.r,
                      child: Lottie.asset(AppImages.imageLottie)
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Text(
                  state.websiteDetail!.name,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  state.websiteDetail!.contact,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  state.websiteDetail!.author,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  state.websiteDetail!.link,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  state.websiteDetail!.likes,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
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
}