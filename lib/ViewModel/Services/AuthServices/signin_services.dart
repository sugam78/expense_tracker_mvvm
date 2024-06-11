
import 'package:expense_tracker_mvvm/Core/Utilities/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Core/Navigation/navigation.dart';
import '../../Controller/Auth/signin_screen_controller.dart';


class SigninServices{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final navigation = Navigation();
  final signinController = SigninScreenController();
  final utilities = Utilities();

  Future<void> signin(String email, String password,BuildContext context) async {
    try {
      SigninScreenController.loading.value = true;
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
        SigninScreenController.loading.value = false;
        navigation.navigateToLoginScreenR(context);
      }).onError((error, stackTrace) {
        SigninScreenController.loading.value = false;
        utilities.toastMesssage(error.toString());
      });

    } on FirebaseAuthException catch (e) {
      utilities.toastMesssage(e.toString());
    } catch (e) {
      utilities.toastMesssage(e.toString());
    }
  }

}