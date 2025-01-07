import 'package:d_chart/commons/data_model/data_model.dart';
import 'package:d_chart/d_chart.dart';
import 'package:expense_app/Bloc%20directory/bloc%20management%20file.dart';
import 'package:expense_app/Bloc%20directory/state%20management.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../Data/local/Models/Expense_model.dart';
import '../Data/local/Models/filter_category_model.dart';
import '../Data/local/Models/filter_expense_model.dart';
import '../Domain/app_constants.dart';

 class statsPage extends StatefulWidget{
  @override
  State<statsPage> createState() => _statsPageState();
 }
 class _statsPageState extends State<statsPage> {
   String defaultTime = "Month Wise";
   DateFormat dFormat = DateFormat.yMMMd();
   String defaultTiming = "Month";
   DateFormat datefmt = DateFormat.yMMM();
   List<filterExpenseModel> filterData = [];
   List<Map<String, dynamic>> mList = [];
   List<filterCategoryModel> filterCategoryData = [];


   @override
   Widget build(BuildContext context) {
     return Scaffold(
         appBar: AppBar(
             title: Text("Statistics"),
             actions: [
               DropdownButton(
                   dropdownColor: Colors.grey.shade200,
                   value: "Date wise",
                   items: [
                     DropdownMenuItem(
                       child: Text("Date wise"), value: "Date wise",),
                     DropdownMenuItem(
                       child: Text("Month wise"), value: "Month wise",),
                     DropdownMenuItem(
                       child: Text("Year wise"), value: "Year wise",),
                   ],
                   onChanged: (value) {
                     defaultTime = value ?? "Date wise";
                     if (value == "Date wise") {
                       dFormat = DateFormat.yMMMMd();
                     } else if (value == "Month wise") {
                       dFormat = DateFormat.yM();
                     } else if (value == "Year wise") {
                       dFormat = DateFormat.y();
                     }
                     setState(() {

                     });
                   }),
             ]
         ),
         body: Column(
           children: [
             SizedBox(height: 20,),
                headerUI(),
                SizedBox(height: 30,),
               ExpenseBreakdownRow(),
               SizedBox(height: 20,),
              barGraph(),
             SizedBox(height: 15,),
            spendingDetails(),
           ]
   )
     );

   }


   void filterDataDatesWise({required List<ExpenseModel> allExp}) {
     filterData.clear();
     List<String> uniqueDates = [];

     for (ExpenseModel eachExp in allExp) {
       String eachDate = dFormat.format(
           DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.createdAt)));
       if (!uniqueDates.contains(eachDate)) {
         uniqueDates.add(eachDate);
       }
     }
     for (String eachDate in uniqueDates) {
       num totalAmt = 0.0;
       List<ExpenseModel> eachDateExp = [];

       for (ExpenseModel eachExp in allExp) {
         String expDate = dFormat.format(
             DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.createdAt)));

         if (eachDate == expDate) {
           eachDateExp.add(eachExp);

           if (eachExp.expenseType == 'Debit') {
             totalAmt += eachExp.amount;
           } else {
             /// credit
             totalAmt -= eachExp.amount;
           }
         }
       }
       filterData.add(filterExpenseModel(
           expenseType: eachDate,
           ttlAmt: totalAmt,
           allExpenses: eachDateExp));
     }
   }


   void filterDataCategoryWise({required List<ExpenseModel> expenseList}) {
     filterCategoryData.clear();
     List<int> uniqueId = [];
     for (ExpenseModel eachExp in expenseList) {
       int eachId = eachExp.categoryId;
       if (!uniqueId.contains(eachId)) {
         uniqueId.add(eachId);
       }
     }
     for (int eachId in uniqueId) {
       double totalAmount = 0;
       String title = " ";
       String expenseType = " ";
       for (ExpenseModel eachExp in expenseList) {
         int expId = eachExp.categoryId;
         if (eachId == expId) {
           title = eachExp.title;
           expenseType = eachExp.expenseType;
           totalAmount = totalAmount + eachExp.amount;
         }
       }
       filterCategoryData.add(filterCategoryModel(
           categoryID: eachId,
           totalAmt: totalAmount,
           title: title,
           expenseType: expenseType));
     }
   }

   Widget headerUI(){
     return  Container(
       height: 150,
       width: 400,
       decoration: BoxDecoration(
         color: Color(0xff6574D3),
         borderRadius: BorderRadius.circular(12),
       ),
       child: Row(
         children: [
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               SizedBox(
                 height: 20,
               ),
               Row(
                 children: [
                   Text("    Total expense", style: TextStyle(
                       color: Colors.white, fontSize: 20),),
                   SizedBox(width: 200,),
                   CircleAvatar(
                     maxRadius: 12,
                     backgroundColor: Colors.grey.shade400,
                     child: Center(child: Text("...")),
                   )
                 ],
               ),
               Row(
                 children: [
                   Text("  \$3,374", style: TextStyle(
                       color: Colors.white,
                       fontSize: 34,
                       fontWeight: FontWeight.bold),),
                   Text("   /\$4000 per month", style: TextStyle(
                       color: Colors.white54, fontSize: 18),)
                 ],
               ),
               SizedBox(
                 height: 10,
               ),
               SizedBox(
                 width: 200,
                 child: LinearProgressIndicator(
                   backgroundColor: const Color(0xff5968BD),
                   color: const Color(0xffEBC68F),
                   borderRadius: BorderRadius.circular(10),
                   minHeight: 4,
                   value: 0.5,
                 ),
               ),
             ],
           )
         ],
       ),
     );
   }


    Widget ExpenseBreakdownRow(){
     return  Row(
       children: [
         Text("   Expense Breakdown", style: TextStyle(
             fontSize: 22, fontWeight: FontWeight.bold),),
         SizedBox(
           width: 100,
         ),
         DropdownButton(
             value: "Date",
             items: [
               DropdownMenuItem(child: Text("Month"), value: "Month",),
               DropdownMenuItem(child: Text("Year"), value: "Year",),
               DropdownMenuItem(child: Text("Date"), value: "Date",),
             ],
             onChanged: (value) {
               defaultTiming = value ?? "Date";
               if (value == "Date") {
                 datefmt = DateFormat.yMMMMd();
               } else if (value == "Year") {
                 datefmt = DateFormat.y();
               } else if (value == "Month") {
                 datefmt = DateFormat.yMMM();
               }
             }
         ),
       ],
     );
    }

    Widget barGraph(){
     return  Expanded(
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
             print(state.mExp);
             filterDataDatesWise(allExp: state.mExp);

             List<OrdinalData> mData = [];
             var highestAmtIndex = -1;
             num highestAmt = 0;

             for (filterExpenseModel eachFilterData in filterData) {
               mData.add(OrdinalData(domain: eachFilterData.expenseType,
                   measure: eachFilterData.ttlAmt));
               if (highestAmt < eachFilterData.ttlAmt) {
                 highestAmt = eachFilterData.ttlAmt;
               }
             }
             return state.mExp.isNotEmpty
                 ? AspectRatio(aspectRatio: 16 / 9,
               child: DChartBarO(
                   fillColor: (group, data, index) {
                     return data.measure == highestAmt ? Colors
                         .limeAccent : Colors.grey;
                   },
                   groupList: [
                     OrdinalGroup(id: "1", data: mData)
                   ]),
             ) : Text("No expenses to visualize");
           }
           return Container();
         }

         )
     );
    }

    Widget spendingDetails(){
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Text("  Spending details", style: TextStyle(
             fontSize: 24, fontWeight: FontWeight.bold)),
         SizedBox(height: 5,),
         Text("   Your expenses are divided into 12 categories",
           style: TextStyle(fontSize: 16),),
         SizedBox(height: 15,),

         /// Progress Bar
         Row(
           children: [
             SizedBox(
               width: 15,
             ),
             Container(
               height: 10,
               width: 100,
               decoration: BoxDecoration(
                   color: Colors.deepPurpleAccent
               ),
             ),
             Container(
               height: 10,
               width: 55,
               decoration: BoxDecoration(
                   color: Colors.purpleAccent
               ),
             ),
             Container(
               height: 10,
               width: 50,
               decoration: BoxDecoration(
                   color: Colors.purpleAccent
               ),
             ),
             Container(
               height: 10,
               width: 55,
               decoration: BoxDecoration(
                   color: Colors.orangeAccent
               ),
             ),
             Container(
               height: 10,
               width: 55,
               decoration: BoxDecoration(
                   color: Colors.blueAccent
               ),
             ),
             Container(
               height: 10,
               width: 55,
               decoration: BoxDecoration(
                   color: Colors.greenAccent
               ),
             ),
           ],
         ),

         /// Grid View
         SizedBox(
           height: 20,),

         BlocBuilder<expenseBloc, expenseState>(builder: (_,state) {
           if( state is expenseLoadingState){
             return const Center(
               child: CircularProgressIndicator(),
             );
           } else if (state is expenseErrorState) {
             return Center(
               child: Text(state.errorMsg),
             );
           } else if(state is expenseLoadedState){
             filterDataCategoryWise(expenseList: state.mExp);
             return filterCategoryData.isNotEmpty ? GridView.builder(
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                 childAspectRatio: 3/2,
                 mainAxisSpacing: 1,
                 crossAxisSpacing: 1,
               ),
               itemCount: filterCategoryData.length,
               physics: NeverScrollableScrollPhysics(),
               shrinkWrap: true,
               itemBuilder: (context, index) {
                 return Padding(
                   padding: const EdgeInsets.all(11.0),
                   child: Container(
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(5),
                         border: Border.all(
                             color: const Color(0xffE0E9F7), width: 2)),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Container(
                           width: 30,
                           height: 40,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(5),
                               color: const Color(0xffE6E9F8)),
                           child: Image.asset(AppConstants
                               .mCat[filterCategoryData[index]
                               .categoryID -
                               1]
                               .imgPath),
                         ),
                         const SizedBox(
                           width: 10,
                         ),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             const SizedBox(
                               height: 20,
                             ),
                             Text(
                               filterCategoryData[index].title,maxLines: 1,overflow: TextOverflow.ellipsis,
                               style: const TextStyle(fontSize: 12),
                             ),
                             const SizedBox(
                               height: 5,
                             ),
                             filterCategoryData[index].expenseType ==
                                 "Credit"
                                 ? Text(
                               "+₹${filterCategoryData[index].totalAmt.toString()}",
                               style: const TextStyle(
                                   fontSize: 14,
                                   color: Colors.green),
                             )
                                 : Text(
                               "-₹${filterCategoryData[index].totalAmt.toString()}",
                               style: const TextStyle(
                                   fontSize: 14,
                                   color: Color(0xffE78BBC)),
                             ),
                           ],
                         )
                       ],
                     ),
                   ),
                 );
               },
             )
                 : const SizedBox(
                 width: double.infinity,
                 height: 200,
                 child: Center(
                   child: Text(
                     "No expense yet!!",
                     style: TextStyle(fontSize: 20),
                   ),
                 ));
           } else {
             return Container();
           }
         }),

         /*SizedBox(
            width: double.infinity,
            height: 320,
            child:
          )*/
       ],
     );
    }

 }