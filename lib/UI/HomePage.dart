import 'dart:developer';

import 'package:expense_app/Bloc%20directory/bloc%20management%20file.dart';
import 'package:expense_app/Bloc%20directory/event%20management.dart';
import 'package:expense_app/Bloc%20directory/state%20management.dart';
import 'package:expense_app/Data/local/Models/Expense_model.dart';
import 'package:expense_app/Data/local/Models/filter_expense_model.dart';
import 'package:expense_app/UI/addExpensePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../Domain/app_constants.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  List<String> mMonths = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  List<ExpenseModel> mExpense = [];
  DateFormat mFormat = DateFormat.yMMM();
  List<filterExpenseModel> filteredData = [];

   @override
   void initState() {
    super.initState();
  context.read<expenseBloc>().add(fetchIntialExpenseEvent());

}
  String defaultTime = "Today";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

      title:  Row(
      children: [
    const Text("Expenso",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
    ],
    ),
        actions: [
          const Icon(Icons.search),
          PopupMenuButton(
            color: Colors.white,
            position: PopupMenuPosition.under,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: const Row(
                    children: [
                      Icon(Icons.logout_outlined,color: Color(0xffE78BBC),),
                      SizedBox(width: 10,),
                      Text("Logout",style: TextStyle(color: Color(0xffE78BBC)),)
                    ],
                  ),
                ),
              ];
            },
          ),
          const SizedBox(width: 5,)
        ],
        backgroundColor: Colors.white,
    ),
       body: Padding(
         padding: const EdgeInsets.all(18.0),
         child: Column(
           children: [
             Row(
               children: [
                 SizedBox(
                   height: 30,
                 ),
                   Padding(
                   padding: const EdgeInsets.all(14.0),
                   child: Container(
                     height:50 ,
                     width: 50,
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       image: DecorationImage(image: NetworkImage("https://thumbs.dreamstime.com/b/cute-boy-face-cartoon-cute-boy-face-cartoon-vector-illustration-graphic-design-110654224.jpg"),
                           fit: BoxFit.cover
                       ),
                     ),
                   ),
                 ),
                 Column(
                   children: [
                     Text("Welcome ", style: TextStyle(fontSize: 18),),
                     SizedBox(height: 5,),
                     Text(".")
                   ],
                 ),
                 SizedBox(width:100),
          StatefulBuilder(builder: (_, ss) {
            return DropdownButton(
              dropdownColor: Colors.grey.shade100,
                value: defaultTime,
                items: [
                  DropdownMenuItem(child: Text("Today"), value: "Today",),
                  DropdownMenuItem(child: Text("This week"), value: "This week",),
                  DropdownMenuItem(child: Text("This month"), value: "This month",),
                  DropdownMenuItem(child: Text("This year"), value: "This year",),
                ],
                onChanged: (value) {
                  defaultTime = value ?? "Today";
                   if(value == "Today"){
                     mFormat = DateFormat.yMMMd();
                   } else if(value == 'This year'){
                     mFormat = DateFormat.yM();
                   }
                  ss(() {});
                });
          }),
               ],
                 ),
             SizedBox(
               height: 15,
             ),
             Container(
               width: 400,
               height: 150,
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                   color: const Color(0xff6574D3)),
               child: Padding(
                 padding: const EdgeInsets.only(left: 20, right: 10),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         const SizedBox(
                           height: 20,
                         ),
                         const Text(
                           "Expense total",
                           style: TextStyle(fontSize: 14, color: Colors.white),
                         ),
                         const SizedBox(
                           height: 5,
                         ),
                         const Text(
                           "\$3,734",
                           style: TextStyle(
                               fontSize: 34,
                               fontWeight: FontWeight.bold,
                               color: Colors.white),
                         ),
                         const SizedBox(
                           height: 5,
                         ),
                         Row(
                           children: [
                             Container(
                               width: 50,
                               height: 24,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(5),
                                   color: const Color(0xffDB6565)),
                               child: const Center(
                                   child: Text(
                                     "+\$240",
                                     style:
                                     TextStyle(fontSize: 14, color: Colors.white),
                                   )),
                             ),
                             const SizedBox(
                               width: 5,
                             ),
                             const Text(
                               "than last month",
                               style: TextStyle(fontSize: 14, color: Colors.white),
                             )
                           ],
                         ),
                         const SizedBox(
                           height: 20,
                         ),
                       ],
                     ),
                     Image.asset(
                       "Assests/Images/expenseAppImg-removebg-preview.png",
                       width: 170,
                       height: 170,
                     )
                   ],
                 ),
               ),
             ),
             const SizedBox(
               height: 20,
             ),
             Row(
               children: [
                 const Text(
                   "Expense List",
                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                 ),
                 SizedBox(width: 115,),
                 TextButton(onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> addExpense()));
                 }, child: Text("Add Expense", style: TextStyle(fontSize: 18),))
               ],
             ),
           SizedBox(
             height: 40,
           ),
             Expanded(
               child:
               BlocBuilder<expenseBloc, expenseState>(builder: (_, state) {
                 if (state is expenseLoadingState) {
                   return Center(
                     child: CircularProgressIndicator(),
                   );
                 } else if (state is expenseErrorState) {
                   return Center(
                     child: Text(state.errorMsg),
                   );
                 } else if (state is expenseLoadedState) {
                   filterDataDateWise(allExp: state.mExp);

                   return state.mExp.isNotEmpty
                       ? ListView.builder(
                       itemCount: filteredData.length,
                       itemBuilder: (_, index) {

                         return Container(
                           margin: EdgeInsets.only(bottom: 11),
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(9),
                             border: Border.all(color: Colors.grey, width: 0.5),
                           ),
                           child: Padding(
                             padding: const EdgeInsets.all(10.0),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text(
                                       filteredData[index].expenseType,
                                       style: TextStyle(
                                           fontSize: 17, fontWeight: FontWeight.bold),
                                     ),
                                     Text(
                                       "-\$${filteredData[index].ttlAmt}",
                                       style: TextStyle(
                                           fontSize: 17, fontWeight: FontWeight.bold),
                                     ),
                                   ],
                                 ),
                                 Divider(),
                                 ListView.builder(
                                     physics: NeverScrollableScrollPhysics(),
                                     itemCount: filteredData[index].allExpenses.length,
                                     shrinkWrap: true,
                                     itemBuilder: (_, childIndex){
                                       return Padding(
                                         padding: const EdgeInsets.only(bottom: 11.0),
                                         child: Row(
                                           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             Container(
                                                 height: 30,
                                                 width: 30,
                                                 decoration: BoxDecoration(
                                                     color: Color(0xFFe0e0e0),
                                                     borderRadius:
                                                     BorderRadius.circular(5)),
                                                 child: Padding(
                                                   padding: const EdgeInsets.all(5.0),
                                                   child: Image.asset(
                                                     AppConstants.mCat
                                                         .where((exp) {
                                                       return exp.id ==
                                                           filteredData[index].allExpenses[childIndex].categoryId;
                                                     })
                                                         .toList()[0]
                                                         .imgPath,
                                                     fit: BoxFit.contain,
                                                     height: 30,
                                                     width: 30,
                                                   ),
                                                 )),
                                             SizedBox(
                                               width: 15,
                                             ),
                                             Column(
                                               crossAxisAlignment:
                                               CrossAxisAlignment.start,
                                               children: [
                                                 Text(
                                                   filteredData[index].allExpenses[childIndex].title,
                                                   style: TextStyle(
                                                       fontSize: 18,
                                                       fontWeight: FontWeight.w500, color: Colors.blue),
                                                 ),
                                                 Text(filteredData[index].allExpenses[childIndex].desc)
                                               ],
                                             ),
                                             Spacer(),
                                             Column(
                                               crossAxisAlignment: CrossAxisAlignment.end,
                                               children: [
                                                 Text(
                                                   mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(filteredData[index].allExpenses[childIndex].createdAt))),
                                                   style: TextStyle(
                                                       fontSize: 11, color: Colors.grey),
                                                 ),
                                                 Text(
                                                   "-\$${filteredData[index].allExpenses[childIndex].amount}",
                                                   style: TextStyle(
                                                       fontSize: 18,
                                                       color: Colors.pinkAccent),
                                                 ),
                                               ],
                                             ),
                                           ],
                                         ),
                                       );
                                     })
                               ],
                             ),
                           ),
                         );


                       })
                       : Center(
                     child: Text("No expenses yet!!"),
                   );
                 }

                 return Container();
               }),
             )
           ],
         ),
       ),
    );




                      }

      void   filterDataDateWise({required List<ExpenseModel> allExp}){
         filteredData.clear();
         List<String> uniqueDates= [];


         for(ExpenseModel eachExp in allExp){
            String eachDate = mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.createdAt)));
            
            print(eachDate);
            if(!uniqueDates.contains(eachDate)){
              uniqueDates.add(eachDate);
            }
         }
         print(uniqueDates);

         for(String eachDate in uniqueDates){
           num totalAmt = 0.0;
           List<ExpenseModel>  eachDateExp = [];

           for(ExpenseModel eachExp in allExp){
             String expDate = mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.createdAt)));

             if(eachDate == expDate){
               eachDateExp.add(eachExp);

               if(eachExp.expenseType=='Debit'){
                 totalAmt +=eachExp.amount;
               }else{
                 /// credit
                 totalAmt -=eachExp.amount;
               }
             }
           }
           filteredData.add(filterExpenseModel(
               expenseType: eachDate,
               ttlAmt: totalAmt,
               allExpenses: eachDateExp));
         }
      }


}