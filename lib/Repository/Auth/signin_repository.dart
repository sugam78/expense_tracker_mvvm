


import 'package:flutter/cupertino.dart';

import '../../ViewModel/Services/AuthServices/signin_services.dart';

class SigninRepository{
  final _signinService = SigninServices();
  Future<void> signinWithEmail(String email,String password,BuildContext context)async{
    await _signinService.signin(email, password,context);

  }
}