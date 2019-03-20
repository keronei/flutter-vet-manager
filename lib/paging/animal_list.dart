/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'animal_edit.dart';
import '../models/animal.dart';
import '../scoped_models/animals.dart';

class AnimalList extends StatelessWidget {

  Widget _iconButton(BuildContext context, int index, AnimalsModel model){

      return  IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          model.selectAnimalIndex(index);
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return EditAnimal(
                );
              }));
        },
      );

  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AnimalsModel>(builder: (BuildContext context, Widget child, AnimalsModel model){
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(model.animals[index].title),
            background: Container(
              color: Colors.red,
              padding: EdgeInsets.only(top: 25.0, right: 15.0),
              child: Text(
                'Delete',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30.0),textAlign: TextAlign.right,
              ),
            ),
            onDismissed: (DismissDirection dir) {
              model.selectAnimalIndex(index);
              if (dir == DismissDirection.endToStart) {
                model.deleteAnimal();
              }
            },
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                      backgroundImage: AssetImage(
                        model.animals[index].imageUrl,
                      )),
                  title: Text(model.animals[index].title),
                  subtitle: Text("Ksh. " + model.animals[index].price.toString()),
                  trailing: _iconButton(context, index, model),
                ),
                Divider(),
              ],
            ),
          );
        },
        itemCount: model.animals.length,
      );
    },);
  }
}
