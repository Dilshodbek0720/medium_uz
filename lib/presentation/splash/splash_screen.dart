import 'package:medium_uz/utils/export/export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // _init() async{
  //   if(StorageRepository.getString("token").isEmpty){
  //     Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
  //   }else{
  //     Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
  //   }
  // }

  @override
  void initState() {
    BlocProvider.of<AuthCubit>(context).checkLoggedState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state){
          return Center(child: Image.asset(AppImages.medium),);
        },
        listener: (context, state){
          if(state is AuthUnAuthenticatedState){
            Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
          }
          if(state is AuthLoggedState){
            Navigator.pushReplacementNamed(context, RouteNames.tabBox);
          }
        },
      )
    );
  }
}
