import 'dart:developer';

import 'package:expense_app/Bloc%20directory/bloc%20management%20file.dart';
import 'package:expense_app/Bloc%20directory/event%20management.dart';
import 'package:expense_app/Bloc%20directory/state%20management.dart';
import 'package:expense_app/Data/local/Models/Expense_model.dart';
import 'package:expense_app/UI/addExpensePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Domain/app_constants.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  List<ExpenseModel> mExpense = [];

  // @override
  // void initState() {
  //   super.initState();
  //   //context.read<expenseBloc>().add(fetchIntialExpenseEvent());
  //
  // }
  String defaultTime = "Today";
/*  var itemsExpenseList = [

    {
      "img": "Assests/Images/shopping.png",
      "title": "Shop",
      "description": "Buy new clothes",
      "amount": "-\$90",
    },
    {
      "img": "Assests/Images/shopping.png",
      "title": "Electronic",
      "description": "Buy new iphone 14",
      "amount": "-\$1290",
    },


    {
      "img": "Assests/Images/shopping.png",
      "title": "Transportation",
      "description": "Trip to Malang",
      "amount": "-\$60",
    },
    {
      "img": "Assests/Images/shopping.png",
      "title": "Shop",
      "description": "Buy new shoes",
      "amount": "-\$100",
    },
  ];
  var daysExpenseList = [
    {
      "date": "Tuesday, 14",
      "totalAmount": "-\$1380",
    },
    {
      "date": "Monday, 13",
      "totalAmount": "-\$60",
    }
  ];  */

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
       body: SingleChildScrollView(
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
                   "  Expense List",
                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                 ),
                 SizedBox(width: 140,),
                 TextButton(onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> addExpense()));
                 }, child: Text("Add Expense", style: TextStyle(fontSize: 18),))
               ],
             ),
           SizedBox(
             height: 40,
           ),
           BlocConsumer<expenseBloc,expenseState>(listener: (context,state){
             if(state is expenseLoadedState){
               var allExp = state.mExp;
               // TODO
                ListView.builder(itemBuilder: (context,index){
                  return Padding(
                    padding:  EdgeInsets.only(bottom: 11.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Color(0xFFe0e0e0),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                AppConstants.mCat.where((exp){
                                  return exp.id==allExp[index].categoryId;
                                }).toList()[0].imgPath,
                                fit: BoxFit.contain,
                                height: 30,
                                width: 30,
                              ),
                            )),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(allExp[index].title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text(allExp[index].desc)
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "-\$${allExp[index].amount}",
                              style: TextStyle(fontSize: 18, color: Colors.pinkAccent),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                });
             }
             else if(state is expenseErrorState){
               log(state.errorMsg.toString());
             }
           },
           builder: (context,state){
             if(state is expenseLoadingState){
               return Center(child: CircularProgressIndicator(),);
             }
             return Center(child: Text("No Data Found"),);
           },

           )

           /// Expense list
           //     BlocBuilder<expenseBloc, expenseState>(builder: (_, state){
           //         if(state is expenseLoadingState){
           //           return Center(child: CircularProgressIndicator(),);
           //         }else if(state is expenseErrorState){
           //           return Center(child: Text(state.errorMsg),);
           //         } else if(state is expenseLoadedState){
           //           return state.mExp.isNotEmpty ? ListView.builder(
           //               itemCount: state.mExp.length,
           //               itemBuilder: (_, index){
           //
           //
           //
           //               }) : Center(child: Text("No expenses yet!!"),);
           //
           //         }
           //
           //         return Container();
           //     }),

               ],
    ),
    ),
    );

                      }
                    }
           /*  SizedBox(
               width: double.infinity,
               height: 450,
               child: ListView.builder(
                 itemCount: daysExpenseList.length,
                 itemBuilder: (context, index) {
                   return Padding(
                     padding: const EdgeInsets.symmetric(vertical: 10),
                     child: Container(
                       width: double.infinity,
                       height: 200,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           border: Border.all(
                               color: const Color(0xffE0E9F7), width: 2)),
                       child: Padding(
                         padding: const EdgeInsets.all(10),
                         child: Column(
                           children: [
                             Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 18),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text(
                                     daysExpenseList[index]["date"].toString(),
                                     style: const TextStyle(
                                         fontSize: 14,
                                         fontWeight: FontWeight.bold),
                                   ),
                                   Text(
                                     daysExpenseList[index]["totalAmount"].toString(),
                                     style: const TextStyle(
                                         fontSize: 14,
                                         fontWeight: FontWeight.bold),
                                   )
                                 ],
                               ),
                             ),
                             const SizedBox(
                               height: 15,
                             ),
                             Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 15),
                               child: Container(
                                 width: double.infinity,
                                 height: 2,
                                 color: const Color(0xffE0E9F7),
                               ),
                             ),
                             const SizedBox(
                               height: 5,
                             ),
                             Flexible(
                               child: SizedBox(
                                 width: double.infinity,
                                 child: ListView.builder(
                                   itemCount: itemsExpenseList.length,
                                   itemBuilder: (context, index) {
                                     return ListTile(
                                       leading: Container(
                                         width: 40,
                                         height: 40,
                                         decoration: BoxDecoration(
                                             borderRadius:
                                             BorderRadius.circular(3),
                                             color: const Color(0xffE6E9F8)),
                                         child: Padding(
                                           padding: const EdgeInsets.all(8),
                                           child: Image.asset(
                                             itemsExpenseList[index]["img"].toString(),
                                           ),
                                         ),
                                       ),
                                       title: Text(
                                         itemsExpenseList[index]["title"].toString(),
                                         style: const TextStyle(fontSize: 14),
                                       ),
                                       subtitle: Text(
                                         itemsExpenseList[index]
                                         ["description"].toString(),
                                         style: const TextStyle(
                                             fontSize: 14, color: Colors.grey),
                                       ),
                                       trailing: Text(
                                         itemsExpenseList[index]["amount"].toString(),
                                         style: const TextStyle(
                                             fontSize: 14,
                                             color: Color(0xffDB6565)),
                                       ),
                                     );
                                   },
                                 ),
                               ),
                             )
                           ],
                         ),
                       ),
                     ),
                   );
                 },
               ),
             ) */





