import 'package:expensetracker/models/expense_model.dart';
import 'package:expensetracker/widgets/expense_card.dart';
import 'package:expensetracker/widgets/expense_chart.dart';
import 'package:expensetracker/widgets/modalscreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ExpenseModel> expenses=[];

  void addExpense(ExpenseModel expense){
    setState(() {
      expenses.add(expense);
    });
  }
  void removeExpense(ExpenseModel expense){
    setState(() {
      expenses.remove(expense);
    });
  }

  void showModal(context){
    // Navigator.of(context).push(MaterialPageRoute(builder:(context) => ModalScreen(),));
    showModalBottomSheet(context: context, builder: (ctx){
     return ModalScreen(addExpense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Expense Tracker"),
        actions: [IconButton(onPressed: () {
          showModal(context);
        }, icon: const Icon(Icons.add))],
      ),
      body: Column(children: [
        Center(
          child: ExpenseChart(expenses: expenses),
        ),

        Expanded(
          child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (ctx,i){
              return ExpenseCard(expense: expenses[i],removeExpense:removeExpense);
            }),
        ),
      ]),
    );
  }
}
