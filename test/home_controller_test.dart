
import 'package:expense_tracker_mvvm/ViewModel/Controller/Home/home_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('Testing toggling function of income and expenditure', (){
    HomeController controller = HomeController();
    controller.toggleIncome();
    expect(controller.showIncome.value,true );
  });
}