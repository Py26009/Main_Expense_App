import 'package:expense_app/Bloc%20directory/bloc%20management%20file.dart';
import 'package:expense_app/Bloc%20directory/event%20management.dart';
import 'package:expense_app/Data/local/Models/Expense_model.dart';
import 'package:expense_app/Data/local/db_helper.dart';
import 'package:expense_app/Domain/UI_helper.dart';
import 'package:expense_app/Domain/app_constants.dart';
import 'package:expense_app/UI/HomePage.dart';
import 'package:expense_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class addExpense extends StatefulWidget{

  @override
  State<addExpense> createState() => _addExpenseState();
}

class _addExpenseState extends State<addExpense> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();

  TextEditingController amountController = TextEditingController();

  String defaultExpenseType = "Debit";

  List<String> mExpenseType = ["Debit", "Credit", "lend", "Borrow", "Loan"];

  int selectedCatIndex = -1;
  DateTime selectedDate = DateTime.now();
  DateFormat mFormat = DateFormat.yMMMd();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
        }, icon:Icon(Icons.keyboard_arrow_left, size: 28, color: Colors.black,)),
        backgroundColor: Color(0xFFB388FF),
        foregroundColor: Colors.white,
        title: Text("Add your expense", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
             child: TextField(
               controller: titleController,
               decoration: mfieldDecor(hint: "Enter the title",
                   heading: "title"),
               ),
           ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: TextField(
              controller: descController,
              decoration: mfieldDecor(hint: "Enter the description",
                  heading: "Description"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: TextField(
              controller: amountController,
              decoration: mfieldDecor(hint: "Enter the amount",
                  heading: "Amount"),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          /// DROP DOWN FOR EXPENSE TYPE
          /// First Method
        /* StatefulBuilder(builder: (_, ss){
           return  DropdownButton(
               value: defaultExpenseType,
               items: [
                 DropdownMenuItem(child: Text("Debit"), value: "Debit",),
                 DropdownMenuItem(child: Text("Credit"), value: "Credit",),
                 DropdownMenuItem(child: Text("lend"), value: "lend",),
                 DropdownMenuItem(child: Text("Borrow"), value: "Borrow",)
               ],
               onChanged: (value){
                 defaultExpenseType = value ?? "Debit";
                 ss((){});
               });
         }) */
          /// SECOND METHOD
               /*  StatefulBuilder(builder: (_,ss){
                   return DropdownButton(
                     value: defaultExpenseType,
                       items: mExpenseType.map((expenseType){
                         return DropdownMenuItem(child: Text(expenseType), value: expenseType,);
                       }).toList(),
                       onChanged: (value){
                       defaultExpenseType = value ?? "Debit";
                       ss((){});
                   });
                 }), */
           StatefulBuilder(builder: (_,ss){
             return DropdownMenu(
               width:  350,
               inputDecorationTheme: InputDecorationTheme(
                 enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(24),
                   borderSide: BorderSide(width: 1),
                     ),
                 focusedBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(24),
                   borderSide: BorderSide(width: 1),
                 )
               ),
               initialSelection: defaultExpenseType,
                 onSelected: (value){
                 defaultExpenseType = value ?? "Debit";
                 },
                 dropdownMenuEntries: mExpenseType.map((expenseType){
               return DropdownMenuEntry(value: expenseType, label: expenseType);
             }).toList());
           }),
          SizedBox(height: 30,),
      InkWell(
        onTap: (){
          showModalBottomSheet(context: context, builder: (_){
            return Container(
              padding: EdgeInsets.symmetric(vertical: 22),
              child: GridView.builder(
                itemCount: AppConstants.mCat.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                  itemBuilder: (_, index){
                return InkWell(
                  onTap: (){
                    selectedCatIndex = index;
                    setState(() {

                    });
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                        Image.asset(AppConstants.mCat[index].imgPath, width: 40, height: 40,),
                      Text(AppConstants.mCat[index].title, maxLines: 1, overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                );
                  },),
            );
          });
        },
        child: Container(
          width: 345,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              width: 1,
              color: Colors.black
            )
          ),
          child: selectedCatIndex >=0 ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppConstants.mCat[selectedCatIndex].imgPath, width: 45,),
              Text(" - ${AppConstants.mCat[selectedCatIndex].title}", style: TextStyle(fontSize: 18),)
            ],
          ):Center(child: Text("Choose a Category", style: TextStyle(fontSize: 18),)),
        )
      ),
          SizedBox(height: 30,),
          InkWell(
              onTap: () async{
                if(Platform.isIOS || Platform.isMacOS){
                   showCupertinoModalPopup(context: context,
                       builder: (_){
                     return Container(
                       height: 100,
                       color: Colors.grey.shade100,
                       child: CupertinoDatePicker(
                         mode: CupertinoDatePickerMode.dateAndTime,
                         initialDateTime: DateTime.now(),
                           minimumDate: DateTime.now().subtract(Duration(days: 365)),
                           minimumYear: DateTime.now().year - 1,
                           maximumYear: DateTime.now().year,
                           maximumDate: DateTime.now(),
                           onDateTimeChanged: (selectedValue){
                           selectedDate = selectedValue;
                           setState(() {

                           });
                           }),
                     );
                       });
                }else{
                  selectedDate= await showDatePicker(context: context,
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime.now()) ?? DateTime.now();
                  setState(() {

                  });
                }
              },
              child: Container(
                width: 345,
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                        width: 1,
                        color: Colors.black
                    )
                ),
                child: Center(
                  child: Text(mFormat.format(selectedDate).toString()),
                )
              ),
          ),
      SizedBox(
        height: 50,
      ),
      Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 1),
          color: Color(0xFFB388FF),
        ),
        child: TextButton(onPressed: () async{
          if(titleController.text.isNotEmpty &&
              descController.text.isNotEmpty &&
              amountController.text.isNotEmpty &&
               selectedCatIndex>-1){
              dbHelper DBHelper = dbHelper.getInstance();
             var prefs = await SharedPreferences.getInstance();
                String uid = prefs.getString("userID") ?? "";

               context.read<expenseBloc>().add(addExpenseEvent(newExp: ExpenseModel(userId:int.parse(uid),
               expenseType: defaultExpenseType,
               title: titleController.text,
               desc: descController.text,
                createdAt: selectedDate.millisecondsSinceEpoch.toString(),
               amount: int.parse(amountController.text),
                balance: 0,
               categoryId: AppConstants.mCat[selectedCatIndex].id)) as expenseEvent);

             Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Expense Added Succesfully"), backgroundColor: Colors.greenAccent,));

    }
    },
          child:
          Text("Add Successfully", style: TextStyle(fontSize: 18),
    ),
      ),
      ),
    ],
      ),
    );

  }
}