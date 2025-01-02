import 'package:expense_app/UI/HomePage.dart';
import 'package:expense_app/UI/addExpensePage.dart';
import 'package:expense_app/UI/bottomNavProvider.dart';
import 'package:expense_app/UI/statisticsPage.dart';
import 'package:expense_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class bottomNavPage extends StatefulWidget{
  @override
  State<bottomNavPage> createState() => _bottomNavPageState();
}

class _bottomNavPageState extends State<bottomNavPage> {
  int selectedIndex = 0;
  List<Widget> navTo = [
    HomePage(),
    addExpense(),
    statsPage(),


  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: navTo[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
        BottomNavigationBarItem(icon: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.purpleAccent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.add, color: Colors.white,),
        ),
            label: " "),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "")
      ],
          iconSize: 30,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap: (value){
        print(value);
        selectedIndex = value;
        setState(() {

        });
        },
      ),
    );
  }
}
