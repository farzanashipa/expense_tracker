import 'package:expense_tracker/db/db_helper.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';


class ExpenceProvider extends ChangeNotifier {

  List<ExpenseModel>expenceList = [];
  late int total;


  Future<int> insertExpence(ExpenseModel expenseModel) =>
      DbHelper.insertExpence(expenseModel);

  void getAllExpence() async {
    expenceList = await DbHelper.getAllExpence();
    expenceList.reversed;
    notifyListeners();
  }

  int gettotalexpence() {
    int totalexp = 0;
    for (var element in expenceList) {
      totalexp = totalexp + element.cost;
    }
    return totalexp;
  }

  int getindivisualcost(String cat) {
    getAllExpence();
    int totalexp = 0;
    for (var element in expenceList.where((element) =>
    element.catagory == cat)) {
      totalexp = totalexp + element.cost;
    }
    total = totalexp;
    return total;
  }




}