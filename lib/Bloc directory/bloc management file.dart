 import 'package:expense_app/Bloc%20directory/event%20management.dart';
import 'package:expense_app/Bloc%20directory/state%20management.dart';
import 'package:expense_app/Data/local/db_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:expense_app/Data/local/db_helper.dart';

class expenseBloc extends Bloc<expenseEvent, expenseState>{
   dbHelper DBHelper;

   expenseBloc({ required this.DBHelper}) : super(expenseInitialState()){

      /// add expenses
      on<addExpenseEvent>((event, emit)async{
         emit(expenseLoadingState());
        bool check = await DBHelper.addExpense(event.newExp);

        if(check){
         var allExp = await  DBHelper.getAllExp();
           emit(expenseLoadedState(mExp: allExp));
        } else{
          emit(expenseErrorState(errorMsg: "Expense cannot be added"));
        }
      });

      /// fetch expenses

      on<fetchIntialExpenseEvent>((event, emit)async{
        emit(expenseLoadingState());
          var allExp = await  DBHelper.getAllExp();
          emit(expenseLoadedState(mExp: allExp));
      });


   }
}