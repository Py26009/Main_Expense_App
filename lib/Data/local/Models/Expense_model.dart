import 'package:expense_app/Data/local/db_helper.dart';
import 'package:flutter/foundation.dart';

class ExpenseModel{
  int ? id;
  int userId;
  String expenseType;
  String title;
  String desc;
  double amount;
  double balance;
  int categoryId;
  String createdAt ;

  ExpenseModel({
      this.id,
     required this.userId,
      required this.expenseType,
      required this.title,
    required this.desc,
    required this.amount,
    required this.balance,
    required this.categoryId,
    required this.createdAt
});

  factory ExpenseModel.forMap(Map<String, dynamic> map){
    return ExpenseModel(
        id: map[dbHelper.TABLE_COLUMN_ID],
        userId: map[dbHelper.EXPENSE_COLUMN_EXPENSETYPE],
        expenseType: map[dbHelper.EXPENSE_COLUMN_ID],
        title: map[dbHelper.EXPENSE_COLUMN_TITLE],
        desc: map[dbHelper.EXPENSE_COLUMN_DESCRIPTION],
        amount: map[dbHelper.EXPENSE_COLUMN_AMOUNT],
        balance: map[dbHelper.EXPENSE_COLUMN_BALANCE],
        createdAt: map[dbHelper.EXPENSE_COLUMN_CREATED_AT],
        categoryId: map[dbHelper.EXPENSE_COLUMN_CAT_ID]);
  }

  Map<String, dynamic> toMap(){
    return {
      dbHelper.EXPENSE_COLUMN_ID : id,
      dbHelper.EXPENSE_COLUMN_BALANCE : balance,
      dbHelper.EXPENSE_COLUMN_CAT_ID : categoryId,
      dbHelper.EXPENSE_COLUMN_DESCRIPTION : desc,
      dbHelper.EXPENSE_COLUMN_AMOUNT : amount,
      dbHelper.EXPENSE_COLUMN_TITLE : title,
      dbHelper.TABLE_COLUMN_ID : userId,
      dbHelper.EXPENSE_COLUMN_EXPENSETYPE : expenseType,
      dbHelper.EXPENSE_COLUMN_CREATED_AT: createdAt

    };
  }

}