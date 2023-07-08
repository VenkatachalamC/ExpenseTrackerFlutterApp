
import 'package:expensetracker/widgets/home_screen.dart';
import 'package:flutter/material.dart';


var kColorScheme=ColorScheme.fromSeed(seedColor: Colors.purpleAccent);
class ExpenseTracker extends StatelessWidget{
  const ExpenseTracker({super.key});
  Widget build(BuildContext context){
    return  MaterialApp(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: kColorScheme.onBackground,
          foregroundColor: kColorScheme.onSecondary
        ),
      ),
      home: HomeScreen(),
    );
  }
}