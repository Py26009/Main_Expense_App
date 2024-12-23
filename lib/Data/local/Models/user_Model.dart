 import 'package:expense_app/Data/local/db_helper.dart';

class UserModel{
  int ? id;
  String  username;
  String  email;
  String  phoneNum;
 String password;
  String ? createdAt;

    UserModel({this.id, required this.username, required this.email, required this.password, this.createdAt, required this.phoneNum});

    factory UserModel.fromMap(Map<String, dynamic> map){
      return UserModel(
         id: map[dbHelper.TABLE_COLUMN_ID],
          username:map[dbHelper.TABLE_COLUMN_USERNAME],
          email: map[dbHelper.TABLE_COLUMN_EMAIL],
          password: map[dbHelper.TABLE_COLUMN_PASSWORD],
          phoneNum: map[dbHelper.TABLE_COLUMN_PHONENUM]
      );
    }

    Map<String, dynamic> toMap(){
      return{
        dbHelper.TABLE_COLUMN_USERNAME: username,
        dbHelper.TABLE_COLUMN_PASSWORD: password,
        dbHelper.TABLE_COLUMN_EMAIL: email,
        dbHelper.TABLE_COLUMN_PHONENUM: phoneNum
      };
}
 }