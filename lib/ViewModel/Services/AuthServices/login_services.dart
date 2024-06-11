
import 'package:expense_tracker_mvvm/Core/Utilities/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Core/Navigation/navigation.dart';
import '../../Controller/Auth/login_screen_controller.dart';

class LoginServices{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final loginController = LoginScreenController();
  final navigation = Navigation();
  final utilities = Utilities();
  Future<void> login(String email, String password,BuildContext context) async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      LoginScreenController.loading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
        sharedPreferences.setBool('isLogin', true);
        LoginScreenController.loading.value = false;
        navigation.navigateToHomeScreenR(context);
      }).onError((error, stackTrace) {
        LoginScreenController.loading.value = false;
        utilities.toastMesssage(error.toString());
      });
    } on FirebaseAuthException catch (e) {
      LoginScreenController.loading.value = false;
      utilities.toastMesssage(e.toString());
    } catch (e) {
      utilities.toastMesssage(e.toString());
    }
  }

}