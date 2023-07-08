
import 'package:expensetracker/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatelessWidget{
  ExpenseCard({super.key,required this.expense,required this.removeExpense});
  final Function (ExpenseModel) removeExpense;
  final ExpenseModel expense;
  final Map<Category,Widget> ico={
    Category.food:Icon(Icons.food_bank),
    Category.fuel:Icon(Icons.gas_meter),
    Category.other:Icon(Icons.money)
  };
  @override
  Widget build(BuildContext context){
    return Dismissible(
      key: ValueKey(expense),
      
      onDismissed: (direction) {
        removeExpense(expense);
      },
      background: Container(
        padding:const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.red[600]
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.delete),
        ]),
      ),
    direction: DismissDirection.startToEnd,
    child: ListTile(
        leading:ico[expense.cat],
        title:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(expense.desc,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400
                ),),
                Text(DateFormat('dd-MM-yyyy').format(expense.date!).toString(),
        style:const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.normal
        )),
            
          ],
        ),
        trailing: Text("₹${expense.price!.round().toString()}",style:
        TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold
        ) ,)
      ),);
  } 
}