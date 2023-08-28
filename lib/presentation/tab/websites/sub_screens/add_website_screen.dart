import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../cubits/website_add/website_add_cubit.dart';
import '../../../../cubits/website_fetch/website_fetch_cubit.dart';
import '../../../../data/models/status/form_status.dart';
import '../../../../data/models/websites/website_field_keys.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/ui_utils/error_message_dialog.dart';
import '../../../auth/widgets/global_button.dart';
import '../../../auth/widgets/global_text_fields.dart';

class AddWebsiteScreen extends StatefulWidget {
  const AddWebsiteScreen({super.key});

  @override
  State<AddWebsiteScreen> createState() => _AddWebsiteScreenState();
}

class _AddWebsiteScreenState extends State<AddWebsiteScreen> {
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Website "),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.black,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black
        ),
      ),
      body: BlocConsumer<WebsiteAddCubit, WebsiteAddState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Add Website",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 16.h,),
              GlobalTextField(
                hintText: "LINK",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                onChanged: (v) {
                  context.read<WebsiteAddCubit>().updateWebsiteField(
                    fieldKey: WebsiteFieldKeys.link,
                    value: v,
                  );
                },
              ),
              SizedBox(height: 20.h,),
              GlobalTextField(
                hintText: "NAME",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                onChanged: (v) {
                  context.read<WebsiteAddCubit>().updateWebsiteField(
                    fieldKey: WebsiteFieldKeys.name,
                    value: v,
                  );
                },
              ),
              SizedBox(height: 20.h,),
              GlobalTextField(
                hintText: "AUTHOR",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                onChanged: (v) {
                  context.read<WebsiteAddCubit>().updateWebsiteField(
                    fieldKey: WebsiteFieldKeys.author,
                    value: v,
                  );
                },
              ),
              SizedBox(height: 20.h,),
              GlobalTextField(
                hintText: "CONTACT",
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                onChanged: (v) {
                  context.read<WebsiteAddCubit>().updateWebsiteField(
                    fieldKey: WebsiteFieldKeys.contact,
                    value: v,
                  );
                },
              ),
              SizedBox(height: 20.h,),
              GlobalTextField(
                hintText: "HASHTAG",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                onChanged: (v) {
                  context.read<WebsiteAddCubit>().updateWebsiteField(
                    fieldKey: WebsiteFieldKeys.hashtag,
                    value: "#$v",
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
              SizedBox(height: 20.h),
              GlobalButton(
                title: "Add Website",
                onTap: () {
                  if (context.read<WebsiteAddCubit>().state.canAddWebsite()) {
                    context.read<WebsiteAddCubit>().createWebsite(context);
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
              state.statusText == StatusTextConstants.websiteAdd) {
            BlocProvider.of<WebsiteFetchCubit>(context).getWebsites(context);
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
      BlocProvider.of<WebsiteAddCubit>(context).updateWebsiteField(
        fieldKey: WebsiteFieldKeys.image,
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
      BlocProvider.of<WebsiteAddCubit>(context).updateWebsiteField(
        fieldKey: WebsiteFieldKeys.image,
        value: xFile.path,
      );
    }
  }
}