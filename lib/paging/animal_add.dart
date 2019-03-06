/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:flutter/material.dart';

class AddNewAnimal extends StatefulWidget {
  final Function addAnimal;


  AddNewAnimal(this.addAnimal);

  @override
  State<StatefulWidget> createState() {
    return _AddNewAnimalState();
  }
}

class _AddNewAnimalState extends State<AddNewAnimal> {
  String AnimalTitle;
  String description;
  double price_;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child:  ListView(
      children: <Widget>[
        TextField(
            onChanged: (String value) {
              setState(() {
                AnimalTitle = value;
              });
            },
            decoration: InputDecoration(
              labelText: "Title",
            )),
        TextField(
          onChanged: (String name) {
           setState(() {
             description = name;
           });
          },
          decoration: InputDecoration(labelText: 'Description'),
        ),
        TextField(
          keyboardType: TextInputType.number,
          onChanged: (String price) {
            setState(() {
              price_ = double.parse(price);
            });
          },
          decoration: InputDecoration(labelText: 'Price'),
        )
        ,
        SizedBox(height: 10.0,),
        RaisedButton(
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
          child: Text('Save'), onPressed: (){
        final Map<String, dynamic> newAnimal = {
          'title': AnimalTitle,
          'desc': description,
          'price':price_,
          'imageUrl':'asset/cat.jpeg'
        };
          widget.addAnimal(newAnimal);
          Navigator.pushReplacementNamed(context, '/');
        },)
      ],
    ),);
  }
}
