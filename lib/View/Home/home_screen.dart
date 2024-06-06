import 'package:expense_tracker_mvvm/Core/Components/dialog_box.dart';
import 'package:expense_tracker_mvvm/Core/Components/reusuable_button.dart';
import 'package:expense_tracker_mvvm/Repository/Home/home_repository.dart';
import 'package:expense_tracker_mvvm/ViewModel/Controller/Home/home_controller.dart';
import 'package:flutter/material.dart';
import '../../Core/Constants/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final homeRepo = HomeRepository();
    final homeController = HomeController();
    final dialogBox = DialogBox();
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [
          IconButton(
              onPressed: () => homeRepo.signOut(context),
              icon: Icon(Icons.logout)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Hello',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              'Welcome to Expense Tracker',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: mq.height * 0.02,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder(
                      future: homeRepo.totalExpenditure(),
                      builder: (context, snapshot) {
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
                                Text('Expenses:'),
                                snapshot.hasData
                                    ? Text(snapshot.data.toString())
                                    : Text('0'),
                                ReusuableButton(
                                  title: 'Add Expense',
                                  onTap: () {
                                    dialogBox.dialogShow(homeController.expenseTitleController.value,
                                        homeController.expenseController.value, '', '', 'Save', () {
                                          homeRepo.addExpense(
                                              homeController.expenseTitleController
                                                  .value.text,
                                              homeController.expenseController.value
                                                  .text);
                                          setState(() {

                                          });
                                        }, context);
                                  },
                                  height: mq.height * 0.04,
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
                  FutureBuilder(
                      future: homeRepo.totalIncome(),
                      builder: (context, snapshot) {
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
                                Text('Income:'),
                                Column(
                                  children: [
                                    Text(snapshot.data.toString()),
                                    ReusuableButton(
                                      title: 'Add Income',
                                      onTap: () {
                                        dialogBox.dialogShow(homeController.incomeTitleController.value, homeController.incomeController.value, '', '', 'Add', ()async{
                                          await homeRepo.addIncome(homeController.incomeTitleController.value.text, homeController.incomeController.value.text);
                                          setState(() {

                                          });
                                        }, context);
                                      },
                                      height: mq.height * 0.04,
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
            Expanded(
              child: FutureBuilder(
                  future: homeRepo.fetchExpenses(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError || snapshot.data == null) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var item = snapshot.data![index];
                          return ListTile(
                            title: Text(item['title'].toString()),
                            subtitle: Text('Rs.${item['amount']}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      dialogBox.dialogShow(homeController.expenseTitleController.value,
                                          homeController.expenseController.value,item['title'],item['amount'], 'Edit Expenditure', ()async{
                                            await homeRepo.editExpense(homeController.expenseTitleController.value.text,
                                                homeController.expenseController.value.text, item['id']);
                                            setState(() {

                                            });
                                          }, context);
                                    }, icon: Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () async{
                                      await homeRepo.deleteExpenditure(item['id']);
                                      setState(() {

                                      });
                                    }, icon: Icon(Icons.delete)),
                              ],
                            ),
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }

}