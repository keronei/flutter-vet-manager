import 'package:flutter/material.dart';

import './animals.dart';


class AnimalManager extends StatelessWidget {
  final List<Map<String, dynamic>> animals;

  AnimalManager(this.animals);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(child: Animals(animals)),
    ]);
  }
}
