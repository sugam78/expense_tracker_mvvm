
import 'package:expense_tracker_mvvm/ViewModel/Controller/Auth/signin_screen_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('Testing password visibility changer function', (){
    SigninScreenController signinScreenController = SigninScreenController();
    signinScreenController.changeVisibility();
    expect(signinScreenController.isVisible.value, true);
  });
}