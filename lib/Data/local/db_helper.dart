import 'dart:developer';

import 'package:expense_app/Data/local/Models/Expense_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'Models/user_Model.dart';

class dbHelper {

  dbHelper._(); /// private class

  static  dbHelper getInstance()=> dbHelper._();  /// Singleton class

  Database ? uDB;  /// Database created
  
  
  /// Context of the Database
  /// TABLE USER

  static final String TABLE_USER = "User";
  static final String TABLE_COLUMN_ID = "u_id";
  static final String TABLE_COLUMN_USERNAME = "u_name";
  static final String TABLE_COLUMN_EMAIL = "u_email";
  static final String TABLE_COLUMN_PASSWORD = "u_password";
  static final String TABLE_COLUMN_PHONENUM = "u_phoneNum";
  static final String TABLE_COLUMN_CREATED_AT = "u_createdAt";


  /// TABLE EXPENSE

  static final String EXPENSE_TABLE = "Expense";
  static final String EXPENSE_COLUMN_ID = "e_id";
  static final String EXPENSE_COLUMN_TITLE = "e_title";
  static final String EXPENSE_COLUMN_DESCRIPTION = "e_desc";
  static final String EXPENSE_COLUMN_AMOUNT = "e_amount";
  static final String EXPENSE_COLUMN_BALANCE= "e_balance";
  static final String EXPENSE_COLUMN_CAT_ID = "e_cat_id";
  static final String EXPENSE_COLUMN_EXPENSETYPE = "e_expense_type";
      static final  String EXPENSE_COLUMN_USER_ID = "u_id";
      static final String EXPENSE_COLUMN_CREATED_AT = "e_createdAt";

  
  /// Initialise the Database

  Future<Database> initDB() async{
    uDB = uDB ?? await openDB();
    return uDB!;
  }

  /// openDB defined
  Future<Database> openDB() async{
    var appDir = await getApplicationDocumentsDirectory();
    var dbPath = join(appDir.path, "expenseDB.db");
    return openDatabase(dbPath, version: 1, onCreate: (db, version){
      print("DataBase created");
      db.execute("CREATE TABLE  $TABLE_USER ( $TABLE_COLUMN_ID integer primary key autoincrement, $TABLE_COLUMN_USERNAME text not null, $TABLE_COLUMN_EMAIL text not null, $TABLE_COLUMN_PASSWORD text not null, $TABLE_COLUMN_PHONENUM text not null )");
      db.execute("CREATE TABLE $EXPENSE_TABLE( $EXPENSE_COLUMN_ID integer primary key autoincrement, $EXPENSE_COLUMN_USER_ID integer, $EXPENSE_COLUMN_AMOUNT integer, $EXPENSE_COLUMN_DESCRIPTION text, $EXPENSE_COLUMN_TITLE text, $EXPENSE_COLUMN_CAT_ID integer, $EXPENSE_COLUMN_BALANCE integer, $EXPENSE_COLUMN_EXPENSETYPE text, $EXPENSE_COLUMN_CREATED_AT text )");
    });
  }

  /// Register user
  /// STEP 1: check for unique email to confirm new user to sign in
   Future<bool> checkForExistingUser({required String email}) async{
    var db = await initDB();
    
   List<Map<String, dynamic>> data = await db.query(TABLE_USER, where: "$TABLE_COLUMN_EMAIL = ?", whereArgs: [email] );
   return data.isNotEmpty;
   }

  /// STEP 2: Register new user
   Future<bool> registerUser({required UserModel newUser})async{
    var db = await initDB();
    int rowsEffected = await db.insert(TABLE_USER, newUser.toMap());
    log(rowsEffected.toString());
    return rowsEffected>0;

    /* if(!await checkForExistingUser(email: newUser.email)){
    int rowsEffected = await db.insert(TABLE_USER, newUser.toMap());
    return rowsEffected>0;
    }else{
      return false;
    }
    */
   }
  /// Login

  Future<bool> authenticateUser({required String email, required String password})async{
    var db = await initDB();
    List<Map<String, dynamic>> mData = await db.query(TABLE_USER, where: "$TABLE_COLUMN_EMAIL = ? AND $TABLE_COLUMN_PASSWORD = ?",
        whereArgs: [email, password]);

    /// Saving userID in prefs
    if(mData.isNotEmpty){
      var prefs = await SharedPreferences.getInstance();
      prefs.setString("userID", mData[0][TABLE_COLUMN_ID].toString());
    }
    return mData.isNotEmpty;
  }

  Future<bool> addExpense(ExpenseModel newExpense) async{
    var db = await initDB();
 /*   var prefs = await SharedPreferences.getInstance();
    String uid  = prefs.getString("userID") ?? "";
    newExpense.userId = uid; */
    int rowEffected = await db.insert(EXPENSE_TABLE, newExpense.toMap());
    return rowEffected>0;
  }

  Future<List<ExpenseModel>> getAllExp() async{

    var db = await initDB();

    List<Map<String,dynamic>> mData = await db.query(EXPENSE_TABLE);
    List<ExpenseModel> allExp = [];

    for(Map<String, dynamic> eachExp in mData){
      allExp.add(ExpenseModel.forMap(eachExp));
    }

    return allExp;

  }
}