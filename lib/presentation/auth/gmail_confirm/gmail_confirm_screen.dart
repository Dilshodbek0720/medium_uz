import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medium_uz/presentation/auth/gmail_confirm/pages/code_input.dart';
import 'package:medium_uz/presentation/auth/gmail_confirm/pages/email_password_input.dart';

import '../../../cubits/auth/auth_cubit.dart';
import '../widgets/global_button.dart';


class GmailConfirmScreen extends StatefulWidget {
  const GmailConfirmScreen({super.key});

  @override
  State<GmailConfirmScreen> createState() => _GmailConfirmScreenState();
}

class _GmailConfirmScreenState extends State<GmailConfirmScreen> {
  final PageController pageController = PageController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController gmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gmail Confirm Screen"),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40.h,),
              Expanded(
                child: PageView(
                  controller: pageController,
                  children: [
                    EmailPasswordInput(
                      gmailController: gmailController,
                      passwordController: passwordController,
                    ),
                    CodeInput(),
                  ],
                ),
              ),
              GlobalButton(
                title: "Next",
                onTap: () {
                  context.read<AuthCubit>().sendCodeToGmail(
                    gmailController.text,
                    passwordController.text,
                  );
                },
              ),
              const SizedBox(height: 50)
            ],
          );
        },
        listener: (context, state) {
          if (state is AuthSendCodeSuccessState) {
            pageController.animateToPage(
              1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear,
            );
          }
        },
      ),
    );
  }
}