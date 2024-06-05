
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Core/Components/reusuable_button.dart';
import '../../Core/Constants/app_constants.dart';
import '../../Core/Navigation/navigation.dart';
import '../../Core/Utilities/utils.dart';
import '../../Repository/Auth/login_repository.dart';
import '../../ViewModel/Controller/Auth/login_screen_controller.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    LoginScreenController loginScreenController = LoginScreenController();
    final loginRepo = LoginRepository();
    final navigation = Navigation();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: loginScreenController.emailController.value,
                focusNode: loginScreenController.emailFocusNode.value,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    )),
                validator: (value) {
                  debugPrint('Validator called\n' * 10);
                  if (value!.isEmpty) {
                    Get.snackbar('Email', 'Enter Email');
                  }
                },
                onFieldSubmitted: (value) {
                  Utilities.fieldFocusChange(
                      context,
                      loginScreenController.emailFocusNode.value,
                      loginScreenController.passwordFocusNode.value);
                },
              ),
              SizedBox(
                height: mq.height * 0.015,
              ),
              TextFormField(
                controller: loginScreenController.passwordController.value,
                focusNode: loginScreenController.passwordFocusNode.value,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    Get.snackbar('Password', 'Enter password');
                  }
                },
              ),
              SizedBox(
                height: mq.height * 0.015,
              ),
              Obx(() => ReusuableButton(
                  title: 'Login',
                  loading: loginScreenController.loading.value,
                  onTap: () async{
                    if (formKey.currentState?.validate()?? false) {
                      await loginRepo.loginWithEmail(
                          loginScreenController.emailController.value.text,
                          loginScreenController.passwordController.value.text,context);
                    }
                  }),),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                      onPressed: () =>navigation.navigateToSigninScreenR(context),
                      child: const Text(
                        'SignIn',
                        style: TextStyle(decoration: TextDecoration.underline),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}