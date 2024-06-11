
import 'package:flutter/cupertino.dart';

import '../../ViewModel/Services/AuthServices/login_services.dart';

class LoginRepository{
  final _loginService = LoginServices();
  Future<void> loginWithEmail(String email,String password,BuildContext context)async{
    await _loginService.login(email, password,context);
  }
}