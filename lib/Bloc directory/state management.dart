  import 'package:expense_app/Data/local/Models/Expense_model.dart';

abstract class expenseState{}

  class expenseInitialState extends expenseState{}
  class expenseLoadingState extends expenseState{}
  class expenseLoadedState extends expenseState{
  List<ExpenseModel> mExp;
  expenseLoadedState({required this.mExp});
  }
  class expenseErrorState extends expenseState{
  String errorMsg;
  expenseErrorState({required this.errorMsg});
  }
