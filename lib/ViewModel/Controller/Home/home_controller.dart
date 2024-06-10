

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  final expenseController = TextEditingController().obs;
  final expenseTitleController = TextEditingController().obs;
  final incomeController = TextEditingController().obs;
  final incomeTitleController = TextEditingController().obs;
  final editExpenseController = TextEditingController().obs;

  var expenses = <Map<String, dynamic>>[].obs;
  var income = <Map<String, dynamic>>[].obs;
  var totalExpenditure = 0.0.obs;
  var totalIncome = 0.0.obs;

  RxBool showIncome = false.obs;

  void toggleIncome(){
    showIncome.value = !showIncome.value;
  }
}