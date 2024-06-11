

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  final expenseController = TextEditingController().obs; //for amount
  final expenseTitleController = TextEditingController().obs; //for title
  final incomeController = TextEditingController().obs; // for amount
  final incomeTitleController = TextEditingController().obs;

  var expenses = <Map<String, dynamic>>[].obs;
  var income = <Map<String, dynamic>>[].obs;
  var totalExpenditure = 0.0.obs;
  var totalIncome = 0.0.obs;

  RxBool showIncome = false.obs; //for toggling income and expenditure show

  void toggleIncome(){
    showIncome.value = !showIncome.value;
  }
}