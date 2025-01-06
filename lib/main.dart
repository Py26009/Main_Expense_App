
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
  runApp(MultiBlocProvider(providers: ({}),
      child: child));
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
      title: 'Flutter Demo',
      themeMode: context.watch<themeProvider>().getThemeValue() ? ThemeMode.dark: ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splashscreen()
      /*uid!="" ? Splashscreen() : loginPage() */,
    );
  }
}

