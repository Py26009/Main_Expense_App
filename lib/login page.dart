import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loginPage extends StatelessWidget{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            height: 350,
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
                  )
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.black.withOpacity(0.2),
                )
              ),
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
                    )
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.black.withOpacity(0.5),
                    )
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(width: 30,),
              Icon(Icons.square_outlined),
              Text(" Remember me", style: TextStyle(fontSize: 18),),
            ],
          ),
          SizedBox(
            height: 20,
          ),
            Container(
              height: 50,
              width: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black,
                width: 1),
                color: Color(0xFFBBDEFB),
              ),
              child:TextButton(onPressed: (){}, child: Text("Continue", style: TextStyle(color: Colors.black, fontSize: 20),))
            ),
          SizedBox(
            height: 40,
          ),
          Text("Don't have an account \n CREATE A ONE NOW", style: TextStyle(fontSize: 18),),
        ],

      ),
    );
  }
}