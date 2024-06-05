import 'package:expense_tracker_mvvm/Core/Routes/routes_name.dart';
import 'package:flutter/material.dart';

class Navigation{

  void navigateToLoginScreenR(BuildContext context){
    Navigator.pushReplacementNamed(context, RouteName.login);
  }
  void navigateToSigninScreenR(BuildContext context){
    Navigator.pushReplacementNamed(context, RouteName.signin);
  }
  void navigateToHomeScreenR(BuildContext context){
    Navigator.pushReplacementNamed(context, RouteName.home);
  }
}