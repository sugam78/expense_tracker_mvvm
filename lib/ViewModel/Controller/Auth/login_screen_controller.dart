import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController{
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  static RxBool loading = false.obs;

  RxBool isVisible = false.obs;

  changeVisibility(){
    isVisible.value = ! isVisible.value;
  }
}