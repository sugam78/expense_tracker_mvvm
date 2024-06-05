import 'package:expense_tracker_mvvm/Core/Routes/routes_name.dart';
import 'package:expense_tracker_mvvm/View/Home/home_screen.dart';
import 'package:expense_tracker_mvvm/View/SplashScreen/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../View/Auth/login_screen.dart';
import '../../View/Auth/signup_screen.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RouteName.splash:
        return MaterialPageRoute(builder: (context)=>SplashScreen());
      case RouteName.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case RouteName.signin:
        return MaterialPageRoute(builder: (context) => SignInScreen());
      case RouteName.home:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      default:
        return MaterialPageRoute(builder: (context)
        {
          return Scaffold(
            body: Center(child: Text('No routes available')),
          );
        });
    }
  }
}