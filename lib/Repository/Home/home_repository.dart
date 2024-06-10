import 'package:expense_tracker_mvvm/ViewModel/Services/HomeServices/home_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ViewModel/Controller/Home/home_controller.dart';

class HomeRepository {
  final homeServices = HomeServices();
  final homeController = Get.find<HomeController>();

  Future<void> signOut(BuildContext context) async {
    await homeServices.signOut(context);
  }

  Future<void> addExpense(String title, String amount) async {
    await homeServices.addExpense(title, amount);
    await fetchExpenses();
  }

  Future<void> editExpense(String title, String amount, String id) async {
    await homeServices.editExpense(title, amount, id);
    await fetchExpenses();
  }

  Future<void> editIncome(String title, String amount, String id) async {
    await homeServices.editIncome(title, amount, id);
    await fetchIncome();
  }

  Future<void> addIncome(String title, String amount) async {
    await homeServices.addIncome(title, amount);
    await fetchIncome();
  }

  Future<void> fetchExpenses() async {
    homeController.expenses.value = await homeServices.fetchExpenses();
    homeController.totalExpenditure.value =
        await homeServices.totalExpenditure();
  }

  Future<void> fetchIncome() async {
    homeController.income.value = await homeServices.fetchIncome();
    homeController.totalIncome.value = await homeServices.totalIncome();
  }

  Future<void> deleteExpenditure(String id) async {
    await homeServices.deleteExpenditure(id);
    await fetchExpenses();
  }

  Future<void> deleteIncome(String id) async {
    await homeServices.deleteIncome(id);
    await fetchIncome();
  }
}
