import 'dart:developer';

import 'package:expense_app/Data/local/Models/user_Model.dart';
import 'package:expense_app/Data/local/db_helper.dart';
import 'package:expense_app/UI/login%20page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  dbHelper DBhelper = dbHelper.getInstance();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                " Let's start your boarding journey ",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    suffix: Icon(Icons.person),
                    hintText: "Enter your name",
                    label: Text("Name"),
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
                padding: const EdgeInsets.all(18.0),
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
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                    onTap: (){
                      isPasswordVisible = !isPasswordVisible;
                      setState((){});
                    },
                    child: Icon(isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined )),
                    hintText: "Enter your password",
                    label: Text("Password"),
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
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    suffix: Icon(Icons.phone_android),
                    hintText: "Enter your phone number",
                    label: Text("Mobile Number"),
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
              SizedBox(
                height: 40,
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
                         if (nameController.text.isNotEmpty &&
                            emailController.text.isNotEmpty &&
                             passwordController.text.isNotEmpty &&
                           phoneNumberController.text.isNotEmpty) {
                          /// register user
                          if (await DBhelper.checkForExistingUser(
                              email: emailController.text.toString())) {
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                               content: Text("Email already exists"),
                             backgroundColor: Colors.blue,
                             ));
                         } else {
                           bool check = await DBhelper.registerUser(
                                newUser: UserModel(
                                    username: nameController.text,
                                  email: emailController.text,
                                 password: passwordController.text,
                                phoneNum: phoneNumberController.text));
                                 log(check.toString());
                            if (check) {
                             ScaffoldMessenger.of(context)
                                 .showSnackBar(SnackBar(
                                content: Text("Account created successfully"),
                              backgroundColor: Colors.green,
                             ));
                             Navigator.pop(context);
                            } else {
                            ScaffoldMessenger.of(context)
                                 .showSnackBar(SnackBar(
                              content: Text(
                                    "Failed to register account!! \n Please try again"),
                              backgroundColor: Colors.red,
                            ));
                            }
                           }
                         }
                      },
                      child: Text(
                        "Create my account",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ))),
              SizedBox(height: 30,),
              Text("Already a user," ,style: TextStyle(fontSize: 20),),
             TextButton(onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=> loginPage()));
             }, child: Text("LOGIN HERE", style: TextStyle(color: Colors.blue, fontSize: 20),))
            ],
          ),
        ),
      ),
    );
  }
}
