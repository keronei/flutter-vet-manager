import 'package:flutter/material.dart';

import './animals.dart';
import './animal_control.dart';

class AnimalManager extends StatelessWidget{

  final List<Map<String, String>> animals;
  final Function addAnimal;
  final Function removeAnimal;

  AnimalManager( this.animals, this.addAnimal, this.removeAnimal) ;


  @override
  Widget build(BuildContext context) {
    return Column( children :[Container(
      margin: EdgeInsets.all(10.0),
      child: AnimalController(addAnimal ),
    ),
       Expanded(child: Animals(animals, deleteAnimal : removeAnimal )),

    ]

    );
  }



}