/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'animal_edit.dart';
import '../models/animal.dart';
import '../scoped_models/main.dart';

class AnimalList extends StatefulWidget {
  final MainModel model;

  AnimalList(this.model);

  @override
  State<StatefulWidget> createState() {
    return _AnimalListState();
  }
}

class _AnimalListState extends State<AnimalList> {

  @override
  initState(){

    widget.model.fetchDataFromServer();
    super.initState();

  }

  Widget _iconButton(BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectAnimalID(model.allAnimals[index].auto_id);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return EditAnimal();
        })).then((_){
          model.selectAnimalID(null);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(model.allAnimals[index].title),
              background: Container(
                color: Colors.red,
                padding: EdgeInsets.only(top: 25.0, right: 15.0),
                child: Text(
                  'Delete',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30.0),
                  textAlign: TextAlign.right,
                ),
              ),
              onDismissed: (DismissDirection dir) {
                model.selectAnimalID(model.allAnimals[index].auto_id);
                if (dir == DismissDirection.endToStart) {
                  model.deleteAnimal();
                }
              },
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                      model.allAnimals[index].imageUrl,
                    )),
                    title: Text(model.allAnimals[index].title),
                    subtitle: Text(
                        "Ksh. " + model.allAnimals[index].price.toString()),
                    trailing: _iconButton(context, index, model),
                  ),
                  Divider(),
                ],
              ),
            );
          },
          itemCount: model.allAnimals.length,
        );
      },
    );
  }
}
