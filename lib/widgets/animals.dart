/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './animals/animals_card.dart';
import '../scoped_models/animals.dart';
import '../models/animal.dart';

class Animals extends StatelessWidget {

  Widget _buildWidgetConditionally(List<Animal> animals) {
    return animals.length > 0
        ? ListView.builder(
            itemBuilder: (BuildContext context, int position) =>
      AnimalCard(animals[position], position),
            itemCount: animals.length,
          )
        : Center(
            child: Text("Looks like there is no animal yet, just add"),
          );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AnimalsModel>(builder: (BuildContext context, Widget child, AnimalsModel scopeModel){
      return _buildWidgetConditionally(scopeModel.animals);
    },) ;
  }
}
