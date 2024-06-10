import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_mvvm/Core/Navigation/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeServices {
  final auth = FirebaseAuth.instance;
  final navigation = Navigation();
  Future<void> signOut(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('isLogin', false);
    auth.signOut();
    navigation.navigateToLoginScreenR(context);
  }

  final fireStore = FirebaseFirestore.instance;
  Future<void> addExpense(String title,String amount) async {
    String path = ('${auth.currentUser!.email}Expenses');
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    await fireStore.collection(path).doc(id).set({
      'title': title,
      'amount': amount,
      'id': id,
    });
  }

  Future<void> editExpense(String title,String amount,String id) async {
    String path = ('${auth.currentUser!.email}Expenses');
    await fireStore.collection(path).doc(id).update({
      'title': title,
      'amount': amount,
      'id': id,
    });
  }
  Future<void> editIncome(String title,String amount,String id) async {
    String path = ('${auth.currentUser!.email}Income');
    await fireStore.collection(path).doc(id).update({
      'title': title,
      'amount': amount,
      'id': id,
    });
  }

  Future<void> addIncome(String title,String amount) async {
    String path = ('${auth.currentUser!.email}Income');
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    await fireStore.collection(path).doc(id).set({
      'title': title,
      'amount': amount,
      'id': id,
    });
  }

  Future<List<Map<String, dynamic>>> fetchExpenses() async {
    try {
      String path = ('${auth.currentUser!.email}Expenses');
      List<Map<String, dynamic>> item = [];
      QuerySnapshot querySnapshot = await fireStore.collection(path).get();
      for (var doc in querySnapshot.docs) {
        item.add(doc.data() as Map<String, dynamic>);
      }
      return item;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchIncome() async {
    try {
      String path = ('${auth.currentUser!.email}Income');
      List<Map<String, dynamic>> item = [];
      QuerySnapshot querySnapshot = await fireStore.collection(path).get();
      for (var doc in querySnapshot.docs) {
        item.add(doc.data() as Map<String, dynamic>);
      }
      return item;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<double> totalExpenditure() async {
    var items = await fetchExpenses();
    double total = 0;
    for (int i = 0; i < items.length; i++) {
      total += double.parse(items[i]['amount']);
    }
    return total;
  }

  Future<double> totalIncome() async {
    var items = await fetchIncome();
    double total = 0;
    for (int i = 0; i < items.length; i++) {
      total += double.parse(items[i]['amount']);
    }
    return total;
  }

  Future<void> deleteExpenditure(String id)async{
    String path = ('${auth.currentUser!.email}Expenses');
    await fireStore.collection(path).doc(id).delete();
  }

  Future<void> deleteIncome(String id)async{
    String path = ('${auth.currentUser!.email}Income');
    await fireStore.collection(path).doc(id).delete();
  }

}
