

import 'package:flutter/material.dart';

class Chart extends StatelessWidget{

  Chart({super.key,required this.total,required this.current,required this.icon});
  final double total,current;
  final Widget icon;

  Widget build(BuildContext context){
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(current.round().toString()),
              Container(
                height:total!=0 && current!=0?(current/total)*100:5,
                width: 50,
                color: Colors.amber,
              ),
              SizedBox(height: 5,),
              icon
            ],
          ),
    );
  }

}