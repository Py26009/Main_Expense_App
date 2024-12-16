import 'package:expense_app/Data/local/db_helper.dart';
import 'package:expense_app/UI/HomePage.dart';
import 'package:expense_app/UI/accountCreation%20Page.dart';

import '';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            height: 300,
            width: 300,
            child: Image.asset("Assests/Images/signup_page_img.png"),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                suffix: Icon(Icons.email),
                hintText: "Enter your email",
                label: Text("Email"),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.black.withOpacity(0.2),
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.black.withOpacity(0.2),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: passwordController,
              decoration: InputDecoration(
                suffix: Icon(Icons.visibility_off),
                hintText: "Enter your password",
                label: Text("Password"),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.black.withOpacity(0.5),
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.black.withOpacity(0.5),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Icon(Icons.square_outlined),
              Text(
                " Remember me",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                width: 70,
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "Forgot Password ?",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
              height: 50,
              width: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black, width: 1),
                color: Color(0xFFBBDEFB),
              ),
              child: TextButton(
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                    // dbHelper DBhelper = dbHelper.getInstance();
                    //
                    // if (emailController.text.isNotEmpty &&
                    //     passwordController.text.isNotEmpty) {
                    //   if (await DBhelper.authenticateUser(
                    //       email: emailController.text,
                    //       password: passwordController.text)) {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => MyHomePage()));
                    //   } else {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //         SnackBar(content: Text("Invalid Credentials")));
                    //   }
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //       content: Text("Please fill all the blanks")));
                    // }
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ))),
          SizedBox(
            height: 20,
          ),
          Text(
            "-------------------------- OR ----------------------------",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Sign up with",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 60,
                width: 70,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Image.network(
                  "https://www.vhv.rs/file/max/20/201053_google-logo-png.png",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 60,
                width: 70,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/e/ee/Logo_de_Facebook.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "             Else, Create your account ",
                style: TextStyle(fontSize: 20),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateAccount()));
                },
                child: Text(
                  "here.",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
