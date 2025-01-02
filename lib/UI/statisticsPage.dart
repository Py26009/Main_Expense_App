import 'package:d_chart/commons/data_model/data_model.dart';
import 'package:d_chart/d_chart.dart';
import 'package:expense_app/Bloc%20directory/bloc%20management%20file.dart';
import 'package:expense_app/Bloc%20directory/state%20management.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../Data/local/Models/Expense_model.dart';
import '../Data/local/Models/filter_expense_model.dart';

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
               DropdownMenuItem(child: Text("Date wise"), value: "Date wise",),
               DropdownMenuItem(child: Text("Month wise"), value: "Month wise",),
               DropdownMenuItem(child: Text("Year wise"), value: "Year wise",),
             ],
             onChanged: (value) {
               defaultTime = value ?? "Date wise";
               if(value== "Date wise"){
                 dFormat = DateFormat.yMMMMd();
               } else if(value == "Month wise"){
                 dFormat = DateFormat.yM();
               }else if(value == "Year wise"){
                 dFormat = DateFormat.y();
               }
             setState(() {

            });
    }),
]
             ),
    body: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          height: 150,
          width: 400,
          decoration: BoxDecoration(
            color: Color(0xff6574D3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start ,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text("    Total expense", style: TextStyle(color: Colors.white, fontSize: 20), ),
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
                      Text("  \$3,374", style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold),),
                      Text("   /\$4000 per month", style: TextStyle(color: Colors.white54, fontSize: 18),)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 8,
                      width: 370,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade500
                      ),
                      child: Container(
                        height: 8,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.orangeAccent
                        ),
                      ),
                    ),
                  ),
                ],
                  )
                ],
              ),
        ),
      SizedBox(
        height: 30,
      ),
      Row(
        children: [
          Text("   Expense Breakdown", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
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
              onChanged: (value){
                 defaultTiming = value ?? "Date";
               if(value == "Date"){
                 datefmt = DateFormat.yMMMMd();
               }else if (value == "Year"){
                 datefmt = DateFormat.y();
               } else if(value == "Month"){
                 datefmt = DateFormat.yMMM();
               }
              }
          ),
      ],
    ),
        SizedBox(height: 20,),
        Expanded(
            child:
            BlocBuilder<expenseBloc,expenseState>(builder: (_, state) {
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
                      ? AspectRatio(aspectRatio: 16/9,
                    child: DChartBarO(
                        fillColor: (group, data, index) {
                          return data.measure == highestAmt ? Colors.limeAccent : Colors.grey;
                        },
                        groupList: [
                          OrdinalGroup(id: "1", data: mData)
                        ]),
                  ) : Text("No expenses to visualize");
                }
                return Container();

            }

              )
        ),
        SizedBox(
          height: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("  Spending details", style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 5,),
            Text("   Your expenses are divided into 12 categories", style: TextStyle(fontSize: 16),),
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
        SizedBox(
          height: 100,
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2/1, crossAxisSpacing: 15, mainAxisSpacing: 15),
                  itemBuilder: (_, index){
                return Center(
               child: Padding(
                 padding: const EdgeInsets.all(18.0),
                 child: Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     border: Border.all( color: Colors.grey),
                   ),
                   child: ListTile(
                     leading: Container(
                       height: 50,
                       width: 50,
                       decoration: BoxDecoration(
                           color: Colors.indigo.withOpacity(0.5),
                           borderRadius: BorderRadius.circular(10)
                       ),
                       child: Icon(Icons.shopping_cart_outlined),
                     ),
                     title: Text("Shop", style: TextStyle(fontSize: 16),),
                   ),
                 ),
               ),
                );
                  }, itemCount: 6,
                  ),
            ),


          ],
        )
      ],
    )
    );

  }


           void filterDataDatesWise({required List<ExpenseModel> allExp}){
              filterData.clear();
              List<String> uniqueDates = [];

              for(ExpenseModel eachExp in allExp){
                String eachDate = dFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.createdAt)));
                if(!uniqueDates.contains(eachDate)){
                  uniqueDates.add(eachDate);
                }
              }
              for(String eachDate in uniqueDates){
                num totalAmt = 0.0;
                List<ExpenseModel>  eachDateExp = [];

                for(ExpenseModel eachExp in allExp){
                  String expDate = dFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.createdAt)));

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
                filterData.add(filterExpenseModel(
                    expenseType: eachDate,
                    ttlAmt: totalAmt,
                    allExpenses: eachDateExp));
              }
    }
              }


