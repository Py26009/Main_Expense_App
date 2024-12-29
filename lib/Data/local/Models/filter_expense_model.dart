import 'package:expense_app/Data/local/Models/Expense_model.dart';
import 'package:expense_app/Data/local/db_helper.dart';
import 'package:flutter/cupertino.dart';

class filterExpenseModel {
  String expenseType;
  num ttlAmt;
  List<ExpenseModel> allExpenses;

  /// Constructor
  filterExpenseModel({
    required this.expenseType,
    required this.ttlAmt,
    required this.allExpenses

});

}