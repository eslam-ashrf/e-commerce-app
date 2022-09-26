import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/home_layout.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/local/dio_helper.dart';
import 'package:shop/shared/network/remote/cash_helper.dart';
import 'package:shop/shared/styles/themes.dart';
import 'bloc_observer.dart';
import 'modules/login/login_screen.dart';
import 'modules/on_boarding/on_board_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CashHelper.init();
  if(CashHelper.getData(key: "onBoarding")==null){
    CashHelper.saveData(key: 'onBoarding', value: false);
  }
  if(CashHelper.getData(key: "token")==null){
    CashHelper.saveData(key: 'token', value: "false");
  }
  bool? onBoarding = CashHelper.getData(key: "onBoarding");
   token = CashHelper.getData(key: "token");
  Widget widget;
  if(onBoarding==true){
    if(token=="false")widget=LoginScreen();
        else widget=HomeLayout();
  }else widget=OnBoardingScreen();
  BlocOverrides.runZoned(
        () {
      runApp( MyApp(widget
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
 late final Widget startScreen;

 MyApp(this.startScreen);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopCubit>(
      create: (BuildContext context)=>ShopCubit()..getHomeData()..getCategoriseData()..getFavorites()..getUserData(),
      child:MaterialApp(
          debugShowCheckedModeBanner: false,
          theme:lightTheme,
          //darkTheme:darkTheme,
          themeMode:ThemeMode.light,
          home:startScreen
      ),

    );
  }
}