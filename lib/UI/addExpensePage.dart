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
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
        ),
        backgroundColor: Color(0xFFB388FF),
        foregroundColor: Colors.white,
        leadingWidth: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(21),
          ),
          side: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
        elevation: 11,
        shadowColor: Colors.blue,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Center(child: Text("Add your Expense", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),)),

           Padding(
             padding: const EdgeInsets.all(25.0),
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
            height: 30,
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
          SizedBox(height: 50,),
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
      SizedBox(
        height: 40,
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
                createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
               amount: double.parse(amountController.text),
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