import 'package:expense_tracker_mvvm/ViewModel/Services/HomeServices/home_services.dart';
import 'package:flutter/material.dart';

class HomeRepository {
  final homeServices = HomeServices();
  Future<void> signOut(BuildContext context) async {
    await homeServices.signOut(context);
  }

  Future<void> addExpense(String title,String amount) async {
    await homeServices.addExpense(title,amount);
  }

  Future<void> editExpense(String title,String amount,String id) async {
    return homeServices.editExpense(title, amount, id);
  }

  Future<void> addIncome(String title,String amount) async {
    await homeServices.addIncome(title,amount);
  }

  Future<List<Map<String, dynamic>>> fetchExpenses() async {
    return await homeServices.fetchExpenses();
  }

  Future<List<Map<String, dynamic>>> fetchIncome() async {
    return await homeServices.fetchIncome();
  }

  Future<void> deleteExpenditure(String id)async{
    await homeServices.deleteExpenditure(id);
  }

  Future<double> totalExpenditure() async {
    return await homeServices.totalExpenditure();
  }

  Future<double> totalIncome() async {
    return homeServices.totalIncome();
  }
}
