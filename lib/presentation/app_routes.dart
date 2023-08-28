import 'package:flutter/material.dart';
import 'package:medium_uz/data/models/user/user_model.dart';
import 'package:medium_uz/presentation/auth/login/login_screen.dart';
import 'package:medium_uz/presentation/splash/splash_screen.dart';
import 'package:medium_uz/presentation/tab/articles/sub_screens/article_add_screen.dart';
import 'package:medium_uz/presentation/tab/articles/sub_screens/article_detail_screen.dart';
import 'package:medium_uz/presentation/tab/tab_box.dart';
import 'package:medium_uz/presentation/tab/websites/sub_screens/add_website_screen.dart';
import 'package:medium_uz/presentation/tab/websites/sub_screens/website_detail_screen.dart';
import 'auth/gmail_confirm/gmail_confirm_screen.dart';
import 'auth/register/register_screen.dart';

class RouteNames {
  static const String splashScreen = "/";
  static const String loginScreen = "/auth_screen";
  static const String registerScreen = "/register_screen";
  static const String tabBox = "/tab_box";
  static const String confirmGmail = "/confirm_gmail";
  static const String addWebsite = "/add_website";
  static const String websiteDetail = "/website_detail";
  static const String articleDetail = "/article_detail";
  static const String addArticle = "/add_article";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RouteNames.loginScreen:
        return MaterialPageRoute(builder: (context) {
          return LoginScreen();
        });

      case RouteNames.registerScreen:
        return MaterialPageRoute(builder: (context) {
          return RegisterScreen();
        });

      case RouteNames.tabBox:
        return MaterialPageRoute(builder: (context) => TabBox());

      case RouteNames.addWebsite:
        return MaterialPageRoute(builder: (context) => AddWebsiteScreen());

      case RouteNames.websiteDetail:
        return MaterialPageRoute(builder: (context) => WebsiteDetailScreen());

      case RouteNames.articleDetail:
        return MaterialPageRoute(builder: (context) => ArticleDetailScreen());

      case RouteNames.addArticle:
        return MaterialPageRoute(builder: (context) => ArticleAddScreen());

      case RouteNames.confirmGmail:
        return MaterialPageRoute(builder: (context) => GmailConfirmScreen(userModel: settings.arguments as UserModel,));

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Route mavjud emas"),
            ),
          ),
        );
    }
  }
}