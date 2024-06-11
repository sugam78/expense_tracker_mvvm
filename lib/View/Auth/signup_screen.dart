
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
final signinScreenController = Get.put(SigninScreenController());
class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    signinScreenController.emailController.value.clear();
    signinScreenController.passwordController.value.clear();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final signinRepo = SigninRepository();
    final navigation = Navigation();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
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
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter email';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  Utilities.fieldFocusChange(
                      context,
                      signinScreenController.emailFocusNode.value,
                      signinScreenController.passwordFocusNode.value);
                },
              ),
              SizedBox(
                height: mq.height * 0.025,
              ),
              Obx((){
                return TextFormField(
                  controller: signinScreenController.passwordController.value,
                  focusNode: signinScreenController.passwordFocusNode.value,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !signinScreenController.isVisible.value,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: signinScreenController.isVisible.value
                          ? IconButton(
                          onPressed: () {
                            signinScreenController.changeVisibility();
                          }, icon: const Icon(Icons.visibility,))
                          : IconButton(
                          onPressed: () {signinScreenController.changeVisibility();}, icon: const Icon(Icons.visibility_off,)),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10),
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter password';
                    }
                    return null;
                  },
                );
              }),
              SizedBox(
                height: mq.height * 0.025,
              ),
              Obx(
                    () => ReusuableButton(
                    title: 'Signin',
                    loading: SigninScreenController.loading.value,
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
              SizedBox(
                height: mq.height * 0.025,
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