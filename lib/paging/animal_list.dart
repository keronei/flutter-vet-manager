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
        return Dismissible(
          key: Key(animalList[index]['title']),
          background: Container(color: Colors.red,),
          child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                  backgroundImage: AssetImage(
                animalList[index]['imageUrl'],
              )),
              title: Text(animalList[index]['title']),
              subtitle: Text("Ksh. " + animalList[index]['price'].toString()),
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
            ),
            Divider(),
          ],
        ),);
      },
      itemCount: animalList.length,
    );
  }
}
