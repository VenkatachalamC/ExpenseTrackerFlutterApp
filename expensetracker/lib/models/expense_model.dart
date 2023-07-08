
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
var uuid = Uuid();
class ExpenseModel {
  String? id;
  double? price;
  Category? cat;
  DateTime? date;
  String desc;
  ExpenseModel({required this.price,this.cat,required this.date,required this.desc}){
    this.id=uuid.v1();
  }
  ExpenseModel.fill({required this.id,required this.cat,required this.date,required this.desc,required this.price});
}
enum Category{fuel,other,food}