import 'package:expense_tracker_mvvm/Core/Components/dialog_box.dart';
import 'package:expense_tracker_mvvm/Core/Components/reusuable_button.dart';
import 'package:expense_tracker_mvvm/Core/Navigation/navigation.dart';
import 'package:expense_tracker_mvvm/Repository/Home/home_repository.dart';
import 'package:expense_tracker_mvvm/ViewModel/Controller/Home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Core/Constants/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeRepo = HomeRepository();
  final homeController = Get.put(HomeController());
  final dialogBox = DialogBox();
  final navigation = Navigation();

  @override
  void initState() {
    super.initState();
    homeRepo.fetchExpenses();
    homeRepo.fetchIncome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: () => homeRepo.signOut(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [

            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    return Container(
                      height: mq.height * 0.15,
                      width: mq.width * 0.35,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Expenses:'),
                            Text(homeController.totalExpenditure.value.toString()),
                            ReusuableButton(
                              title: 'Add Expense',
                              onTap: () {
                                dialogBox.dialogShow(
                                  homeController.expenseTitleController.value,
                                  homeController.expenseController.value,
                                  '',
                                  '',
                                  'Save',
                                      () {
                                    homeRepo.addExpense(
                                      homeController.expenseTitleController.value.text,
                                      homeController.expenseController.value.text,
                                    );
                                  },
                                  context,
                                );
                              },
                              height: mq.height * 0.035,
                              width: mq.width * 0.28,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  SizedBox(
                    width: mq.width * 0.04,
                  ),
                  Obx(() {
                    return Container(
                      height: mq.height * 0.15,
                      width: mq.width * 0.35,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Income:'),
                            Column(
                              children: [
                                Text(homeController.totalIncome.value.toString()),
                                ReusuableButton(
                                  title: 'Add Income',
                                  onTap: () {
                                    dialogBox.dialogShow(
                                      homeController.incomeTitleController.value,
                                      homeController.incomeController.value,
                                      '',
                                      '',
                                      'Add',
                                          () async {
                                        await homeRepo.addIncome(
                                          homeController.incomeTitleController.value.text,
                                          homeController.incomeController.value.text,
                                        );
                                      },
                                      context,
                                    );
                                  },
                                  height: mq.height * 0.035,
                                  width: mq.width * 0.28,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            TextButton(onPressed: (){
              homeController.toggleIncome();
            }, child: Obx((){
             return homeController.showIncome.value? const Text('Show Expenditure'): const Text('Show Income');
            }
            )),

            Obx((){
              return homeController.showIncome.value? Expanded(
                child: Obx(() {
                  if (homeController.income.isEmpty) {
                    return const Center(child: Text('Add Income'));
                  }
                  return ListView.builder(
                    itemCount: homeController.income.length,
                    itemBuilder: (context, index) {
                      var item = homeController.income[index];
                      return ListTile(
                        title: Text(item['title'].toString()),
                        subtitle: Text('Rs.${item['amount']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                dialogBox.dialogShow(
                                  homeController.incomeTitleController.value,
                                  homeController.incomeController.value,
                                  item['title'],
                                  item['amount'],
                                  'Edit Income',
                                      () async {
                                    await homeRepo.editIncome(
                                      homeController.expenseTitleController.value.text,
                                      homeController.expenseController.value.text,
                                      item['id'],
                                    );
                                  },
                                  context,
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () async {
                                await homeRepo.deleteIncome(item['id']);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ): Expanded(
                child: Obx(() {
                  if (homeController.expenses.isEmpty) {
                    return const Center(child: Text('Add Expense'));
                  }
                  return ListView.builder(
                    itemCount: homeController.expenses.length,
                    itemBuilder: (context, index) {
                      var item = homeController.expenses[index];
                      return ListTile(
                        title: Text(item['title'].toString()),
                        subtitle: Text('Rs.${item['amount']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                dialogBox.dialogShow(
                                  homeController.expenseTitleController.value,
                                  homeController.expenseController.value,
                                  item['title'],
                                  item['amount'],
                                  'Edit Expenditure',
                                      () async {
                                    await homeRepo.editExpense(
                                      homeController.expenseTitleController.value.text,
                                      homeController.expenseController.value.text,
                                      item['id'],
                                    );
                                  },
                                  context,
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () async {
                                await homeRepo.deleteExpenditure(item['id']);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              );
            }),
            TextButton(onPressed: (){
              navigation.navigateToChartScreen(context);
            }, child: const Text('View Chart')),
          ],
        ),
      ),
    );
  }
}
