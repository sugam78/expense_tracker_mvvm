import 'package:expense_tracker_mvvm/Repository/Home/home_repository.dart';
import 'package:expense_tracker_mvvm/ViewModel/Controller/Home/home_controller.dart';
import 'package:get/get.dart';

class ChartController {
  final homeController = Get.find<HomeController>();
  final homeRepo = HomeRepository();


  Future<dynamic> setData() async {
    await homeRepo.fetchExpenses();
    Map<String, double> data = {};
    for (int i = 0; i < homeController.expenses.length; i++) {
      data[homeController.expenses[i]['title']] =  double.parse(homeController.expenses[i]['amount']);
    }
    data['Saving'] = homeController.totalIncome.value - homeController.totalExpenditure.value;
    if(homeController.totalIncome.value - homeController.totalExpenditure.value < 0){
      return 'Income is Less than Expenditure';
    }
    else if(homeController.totalIncome.value ==0 &&homeController.totalExpenditure.value == 0){
      return 'No data';
    }
    return data;
  }
}
