

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  final expenseController = TextEditingController().obs;
  final expenseTitleController = TextEditingController().obs;
  final incomeController = TextEditingController().obs;
  final incomeTitleController = TextEditingController().obs;
  final editExpenseController = TextEditingController().obs;
}