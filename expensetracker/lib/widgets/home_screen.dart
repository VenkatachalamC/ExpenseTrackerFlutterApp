import 'package:expensetracker/models/expense_model.dart';
import 'package:expensetracker/widgets/expense_card.dart';
import 'package:expensetracker/widgets/expense_chart.dart';
import 'package:expensetracker/widgets/modalscreen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ExpenseModel> expenses=[];
  var db;
  final dummyMap={
    "Category.food":Category.food,
    "Category.fuel":Category.fuel,
    "Category.other":Category.other
  };
  void initState(){
    init();
  }
  void init() async{
    this.db=await openDatabase(join(await getDatabasesPath(),"expenses.db"),onCreate: (db, version) {
      return db.execute('CREATE TABLE expenses(id TEXT PRIMARY KEY,price double,cat TEXT,desc TEXT,date TEXT)');
    },
    version: 1);
    List<Map<String,dynamic>> data=await db.query('expenses');
    List<ExpenseModel> dummy=[];
    for(int i=0;i<data.length;i++){
      dummy.add(ExpenseModel.fill(id: data[i]['id'], cat: dummyMap[data[i]['cat']], date: DateTime.parse(data[i]['date']), desc: data[i]['desc'], price: data[i]['price']));
    }
    setState(() {
      expenses=dummy;
    });
  }
  void addExpense(ExpenseModel expense) async{
    await db.insert('expenses',{
      'id':expense.id,
      'price':expense.price,
      'cat':expense.cat.toString(),
      'desc':expense.desc,
      'date':expense.date.toString()
    });
    setState(() {
      expenses.add(expense);
    });
  }
  void removeExpense(ExpenseModel expense) async{
    await db.delete('expenses',
    where:'id=?',
    whereArgs:[expense.id]
    );
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
