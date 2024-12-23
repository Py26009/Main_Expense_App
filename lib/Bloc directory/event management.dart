 import 'package:expense_app/Data/local/Models/Expense_model.dart';

abstract class expenseEvent {}

 class addExpenseEvent extends expenseEvent{
  ExpenseModel newExp;
  addExpenseEvent({required this.newExp});

 }

  class fetchIntialExpenseEvent extends expenseEvent{}