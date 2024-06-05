
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Core/Components/reusuable_button.dart';
import '../../Core/Constants/app_constants.dart';
import '../../Core/Navigation/navigation.dart';
import '../../Core/Utilities/utils.dart';
import '../../Repository/Auth/signin_repository.dart';
import '../../ViewModel/Controller/Auth/signin_screen_controller.dart';



class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    SigninScreenController signinScreenController = SigninScreenController();
    final signinRepo = SigninRepository();
    final navigation = Navigation();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: signinScreenController.emailController.value,
                focusNode: signinScreenController.emailFocusNode.value,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    Get.snackbar('Email', 'Enter Email');
                  }
                },
                onFieldSubmitted: (value) {
                  Utilities.fieldFocusChange(
                      context,
                      signinScreenController.emailFocusNode.value,
                      signinScreenController.passwordFocusNode.value);
                },
              ),
              SizedBox(
                height: mq.height * 0.015,
              ),
              TextFormField(
                controller: signinScreenController.passwordController.value,
                focusNode: signinScreenController.passwordFocusNode.value,
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
              Obx(
                    () => ReusuableButton(
                    title: 'Signin',
                    loading: signinScreenController.loading.value,
                    onTap: () async{
                      if (formKey.currentState?.validate()?? false) {
                        await signinRepo.signinWithEmail(
                            signinScreenController.emailController.value.text,
                            signinScreenController.passwordController.value.text,
                            context
                        );
                      }
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                      onPressed: () => navigation.navigateToLoginScreenR(context),
                      child: const Text(
                        'Login',
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