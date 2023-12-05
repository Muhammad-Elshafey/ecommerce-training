import 'package:ecommerce_trainning/screens/modules/login_screen.dart';
import 'package:ecommerce_trainning/screens/modules/onboarding_screen.dart';
import 'package:ecommerce_trainning/screens/modules/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/controllers/login_cubit/login_cubit.dart';
import 'core/controllers/observer.dart';
import 'core/controllers/onboarding_cubit/onboarding_cubit.dart';
import 'core/controllers/register_cubit/register_cubit.dart';
import 'core/managers/themes.dart';
import 'core/managers/values.dart';
import 'core/network/local/cache_helper.dart';
import 'core/network/remote/dio_helper.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelperStore.init();
  await CacheHelper.init();
  boarding = CacheHelper.getData(key: 'Boarding');
  token = CacheHelper.getData(key:'token');
  natoinalId = CacheHelper.getData(key:'userId');
  print(token);
  print(natoinalId);
  print(boarding);
  if(boarding){
    nextScreen = LoginScreen();
  }else{
    nextScreen =const OnboardingScreen();
  }
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => OnBoardingCubit(),
        lazy: true,
      ),
      BlocProvider(
        create: (context) => RegisterCubit(),
        lazy: true,
      ),
      BlocProvider(
        create: (context) => LoginCubit(),
        lazy: true,
      ),
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme:lightTheme,
        home:nextScreen,
      ),
    );
  }
}
