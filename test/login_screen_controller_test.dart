
import 'package:expense_tracker_mvvm/ViewModel/Controller/Auth/login_screen_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('Testing password visibility changer', (){
    LoginScreenController loginScreenController = LoginScreenController();
    loginScreenController.changeVisibility();
    expect(loginScreenController.isVisible.value, true);
  });
}