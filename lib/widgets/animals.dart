/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:flutter/material.dart';
import '../paging/animal.dart';
import './animals/animals_card.dart';
import '../models/animal.dart';

class Animals extends StatelessWidget {
  final List<Animal> animals;

  Animals(this.animals) {}


  Widget _buildWidgetConditionally() {
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
    return _buildWidgetConditionally();
  }
}
