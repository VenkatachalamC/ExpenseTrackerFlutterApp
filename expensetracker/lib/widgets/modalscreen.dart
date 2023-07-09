//import 'package:expensetracker/models/category.dart';
import 'package:expensetracker/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ModalScreen extends StatefulWidget {
  ModalScreen(this.addExpense);
  Function(ExpenseModel) addExpense;
  @override
  State<ModalScreen> createState() => _ModalScreenState(addExpense);
}

class _ModalScreenState extends State<ModalScreen> {
  _ModalScreenState(this.addExpense);
  Function(ExpenseModel) addExpense;
  Category? _cat = Category.food;
  late TextEditingController _price;
  late TextEditingController _desc;
  double? price;
  DateTime? _date;
  @override
  void initState() {
    super.initState();
    _desc=TextEditingController();
    _price = TextEditingController();
  }

  @override
  void dispose() {
    _price.dispose();
    _desc.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: TextField(
                  decoration:const InputDecoration(
                    hintText: "Amount",
                  ),
                  controller: _price,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: Center(
                  child: DropdownButton(
                      itemHeight: 50,
                      value: _cat,
                      items: const [
                        DropdownMenuItem(
                            value: Category.food,
                            child: Row(
                                children: [Icon(Icons.food_bank), Text("food")])),
                        DropdownMenuItem(
                            value: Category.fuel,
                            child: Row(
                                children: [Icon(Icons.gas_meter), Text("fuel")])),
                        DropdownMenuItem(
                            value: Category.other,
                            child:
                                Row(children: [Icon(Icons.money), Text("other")]))
                      ],
                      onChanged: (value) {
                        setState(() {
                          _cat = value;
                        });
                      }),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: _desc,
            decoration: const InputDecoration(
              hintText: "description",
          ),
          maxLength: 50,
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () async {
                    DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(const Duration(
                          days: 365,
                        )),
                        lastDate: DateTime.now());
                    if (date == null) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("please select a date.."),
                        duration: Duration(seconds: 3),
                      ));
                    } else {
                      setState(() {
                        _date = date;
                      });
                    }
                  },
                  icon: Icon(Icons.date_range)),
                  _date!=null? Text(DateFormat('dd-MM-yyyy').format(_date!).toString()):Text(""),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    if(!_price.text!.isEmpty){
                    addExpense(ExpenseModel(
                        price: double.parse(_price.text),
                        date: _date,
                        cat: _cat,
                        desc:_desc.text));
                      Navigator.of(context).pop();
                    }
                    else{
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Amount can't be empty"),duration:Duration(seconds: 3),));
                    }
                  },
                  child: const Text("Add Expense")),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.cancel),
              )
            ],
          )
        ],
      ),
    );
  }
}
