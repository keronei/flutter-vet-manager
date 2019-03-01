import 'package:flutter/material.dart';

import './animals.dart';
import './animal_control.dart';

class AnimalManager extends StatefulWidget{
   final String mInitialData;

  AnimalManager({this.mInitialData});

  @override
  State<StatefulWidget> createState() {
    return _AnimalManagerState();
  }

}



class _AnimalManagerState extends State<AnimalManager>{

  List<String> _animals =  [];

  @override
  void initState() {
    if(widget.mInitialData != null) {
      _animals.add(widget.mInitialData);
    }
    super.initState();
  }

  void _addAnAnimal(String animal){
    setState(() {
      _animals.add("Literal ones");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column( children :[Container(
      margin: EdgeInsets.all(10.0),
      child: AnimalController(_addAnAnimal ),
    ),
       Expanded(child: Animals(_animals)),

    ]

    );
  }

}