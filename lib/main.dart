
import 'package:expense_app/Bloc%20directory/bloc%20management%20file.dart';
import 'package:expense_app/Bloc%20directory/event%20management.dart';
import 'package:expense_app/Data/local/db_helper.dart';
import 'package:expense_app/UI/HomePage.dart';
import 'package:expense_app/UI/SplashScreen.dart';
import 'package:expense_app/UI/addExpensePage.dart';
import 'package:expense_app/UI/createAccount.dart';
import 'package:expense_app/UI/login%20page.dart';
import 'package:expense_app/UI/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
  MultiBlocProvider(providers:[
    BlocProvider(create: (context)=> expenseBloc(DBHelper: dbHelper.getInstance())..add(fetchIntialExpenseEvent())),
    ChangeNotifierProvider(create: (context)=> themeProvider()),

  ],
      child: const MyApp()));
     /* BlocProvider(
    create: (context)=> expenseBloc(DBHelper: dbHelper.getInstance())..add(fetchIntialExpenseEvent()),

      child: const MyApp()));*/
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String uid ='';
  @override
  void initState() {
    super.initState();
   // getPrefsValue();
  }

   void getPrefsValue()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString("uid") ?? "";
    setState(() {

    });
   }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: context.watch<themeProvider>().getThemeValue() ? ThemeMode.dark :ThemeMode.light,
      darkTheme: ThemeData(brightness: Brightness.dark),
      theme: ThemeData(brightness: Brightness.light),
      title: 'Flutter Demo',
      home: Splashscreen()
      /*uid!="" ? Splashscreen() : loginPage() */,
    );
  }
}

