/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:flutter/material.dart';
import 'animal_edit.dart';

class AnimalList extends StatelessWidget {
  final List<Map<String, dynamic>> animalList;
  final Function updateAnimal;

  AnimalList(this.animalList, this.updateAnimal);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: CircleAvatar(backgroundImage:AssetImage(
                animalList[index]['imageUrl'],
              )),
          title: Text(animalList[index]['title']),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return editAnimal(
                  singleAnimal: animalList[index],
                  updateAnimal: updateAnimal,
                  animalIndex: index,
                );
              }));
            },
          ),
        );
      },
      itemCount: animalList.length,
    );
  }
}
