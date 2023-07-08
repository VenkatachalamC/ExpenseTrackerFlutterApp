

import 'package:expensetracker/models/expense_model.dart';
import 'package:expensetracker/widgets/chart.dart';
import 'package:flutter/material.dart';

class ExpenseChart extends StatelessWidget{

  ExpenseChart({required this.expenses}):foodexpense=0,otherexpense=0,fuelexpense=0,total=0;
  final List<ExpenseModel> expenses;
  double foodexpense,otherexpense,fuelexpense,total;
  Widget build(BuildContext context){
    calculateChart();
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Chart(total:total,current: foodexpense,icon: Icon(Icons.food_bank),),
            Chart(total:total,current: fuelexpense,icon: Icon(Icons.gas_meter),),
            Chart(total:total,current: otherexpense,icon: Icon(Icons.money),),
        ],),
      ),
    );
  }

  void calculateChart(){
    for(ExpenseModel expense in expenses){
      this.total=this.total+expense.price!;
      if(expense.cat==Category.food){
        this.foodexpense=this.foodexpense+expense.price!;
      }
      else if(expense.cat==Category.fuel){
        this.fuelexpense=this.fuelexpense+expense.price!;
      }
      else{
        this.otherexpense=this.otherexpense+expense.price!;
      }
    }
  }

}