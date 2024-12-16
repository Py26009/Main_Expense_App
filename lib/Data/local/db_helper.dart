import 'dart:developer';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'Models/user_Model.dart';

class dbHelper {

  dbHelper._(); /// private class

  static  dbHelper getInstance()=> dbHelper._();  /// Singelton class

  Database ? uDB;  /// Database created
  
  
  /// Context of the Database

  static final String TABLE_USER = "User";
  static final String TABLE_COLUMN_ID = "u_id";
  static final String TABLE_COLUMN_USERNAME = "u_name";
  static final String TABLE_COLUMN_EMAIL = "u_email";
  static final String TABLE_COLUMN_PASSWORD = "u_password";
  static final String TABLE_COLUMN_PHONENUM = "u_phoneNum";
  static final String TABLE_COLUMN_CREATED_AT = "u_createdAt";
  
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
      db.execute("CREATE TABLE  $TABLE_USER ( $TABLE_COLUMN_ID integer primary key autoincrement, $TABLE_COLUMN_USERNAME text not null, $TABLE_COLUMN_EMAIL text not null, $TABLE_COLUMN_PASSWORD text not null, $TABLE_COLUMN_PHONENUM text not null, $TABLE_COLUMN_CREATED_AT text not null )");
    });
  }

  /// Register user
  /// STEP 1: check for unique email to confirm new user to sign in
   Future<bool> checkForExistingUser({required String email}) async{
    var db = await initDB();
    
   List<Map<String, dynamic>> data = await db.query(TABLE_USER, where: "$TABLE_COLUMN_EMAIL = $email");
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
    List<Map<String, dynamic>> mData = await db.query(TABLE_USER, where: "$TABLE_COLUMN_EMAIL = ? && $TABLE_COLUMN_PASSWORD = ?",
        whereArgs: [email, password]);

    /// Saving userID in prefs
    if(mData.isNotEmpty){
      var prefs = await SharedPreferences.getInstance();
      prefs.setString("userID", mData[0][TABLE_COLUMN_ID].toString());
    }
    return mData.isNotEmpty;
  }
}