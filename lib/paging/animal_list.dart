/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:flutter/material.dart';
import 'animal_edit.dart';
import '../models/animal.dart';

class AnimalList extends StatelessWidget {
  final List<Animal> animalList;
  final Function updateAnimal;
  final Function removeAnimal;

  AnimalList(this.animalList, this.updateAnimal, this.removeAnimal);

  Widget _iconButton(BuildContext context, int index){
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return editAnimal(
                singleAnimal: animalList[index],
                updateAnimal: updateAnimal,
                animalIndex: index,
              );
            }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(animalList[index].title),
          background: Container(
            color: Colors.red,
            padding: EdgeInsets.only(top: 25.0, right: 15.0),
            child: Text(
              'Delete',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30.0),textAlign: TextAlign.right,
            ),
          ),
          onDismissed: (DismissDirection dir) {
            if (dir == DismissDirection.endToStart) {
              removeAnimal(index);
            }
          },
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                    backgroundImage: AssetImage(
                  animalList[index].imageUrl,
                )),
                title: Text(animalList[index].title),
                subtitle: Text("Ksh. " + animalList[index].price.toString()),
                trailing: _iconButton(context, index),
              ),
              Divider(),
            ],
          ),
        );
      },
      itemCount: animalList.length,
    );
  }
}
