import 'package:medium_uz/utils/export/export.dart';
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
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteNames.loginScreen:
        return MaterialPageRoute(builder: (context) {
          return const LoginScreen();
        });

      case RouteNames.registerScreen:
        return MaterialPageRoute(builder: (context) {
          return const RegisterScreen();
        });

      case RouteNames.tabBox:
        return MaterialPageRoute(builder: (context) => const TabBox());

      case RouteNames.addWebsite:
        return MaterialPageRoute(builder: (context) => const AddWebsiteScreen());

      case RouteNames.websiteDetail:
        return MaterialPageRoute(builder: (context) => const WebsiteDetailScreen());

      case RouteNames.articleDetail:
        return MaterialPageRoute(builder: (context) => const ArticleDetailScreen());

      case RouteNames.addArticle:
        return MaterialPageRoute(builder: (context) => const ArticleAddScreen());

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