import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/shop_app/shop_layout.dart';
import 'package:udemy_flutter/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/social_app/social_layout.dart';
import 'package:udemy_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutter/modules/social_app/social_login/social_login_screen.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';
import 'package:udemy_flutter/shared/network/local/cash_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter/shared/styles/themes.dart';
import 'layout/news_app/cubit/cubit.dart';
import 'layout/shop_app/cubit/cubit.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'shared/bloc_observer.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();
  bool isDark = CashHelper.getData(key:'isDark');

  Widget widget;
  //bool onBoarding = CashHelper.getData(key:'onBoarding');
  //token = CashHelper.getData(key:'token');
   uId = 'pCvQZLKPPLcltSwvCd7tubOxRBP2';
  //CashHelper.getData(key:'uId');

  // if(onBoarding !=null){
  //   if(token != null) widget=ShopLayout();
  //   else widget=ShopLoginScreen();
  // }else{
  //   widget=OnBoardingScreen();
  // }
  if(uId !=null){
    widget= SocialLayout();
  }else{
    widget= SocialLoginScreen();
  }

  runApp(MyApp(isDark:isDark ,startWidget:widget ,));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget
{
  final bool isDark;
  final Widget startWidget;
  MyApp({@required this.isDark,@required this.startWidget});
  // constructor
  // build

  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> NewsCubit()..getBusiness()..getSports()..getScience()),
        BlocProvider(create: (context)=>AppCubit()..changeAppMode(fromShared: isDark),),
        BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData()),
        BlocProvider(create: (context)=>SocialCubit()..getUserData()..getPosts()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:  lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark :ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
