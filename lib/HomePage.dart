import 'dart:async';

import 'package:expense_app/login%20page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginPage()));
    } );
    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        children: [
          SizedBox(
            height: 120,
          ),
          Center(
            child: Container(
              height: 280,
              width: 280,
              color: Colors.white54,
              child: Image.asset("Assests/Images/monety_app_img.png"),
            ),
          ),
        SizedBox(
          height: 40,
        ),
        Text(" Easy way to monitor your expense", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
        SizedBox(height: 30,),
          Text("     Safe your future by managing your expense right now", style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 20), textAlign: TextAlign.center,),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}