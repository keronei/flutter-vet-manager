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

  final GlobalKey<FormState> _globalKey =  GlobalKey<FormState>();
  Widget _buildAnimalTitleTextField() {
    return TextFormField(
        onSaved: (String value) {
          setState(() {
            AnimalTitle = value;
          });
        },
        decoration: InputDecoration(
          labelText: "Title",
        ));
  }

  Widget _buildAnimalDescriptionTextField() {
    return TextFormField(
      onSaved: (String name) {
        setState(() {
          description = name;
        });
      },
      decoration: InputDecoration(labelText: 'Description'),
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (String price) {
        setState(() {
          price_ = double.parse(price);
        });
      },
      decoration: InputDecoration(labelText: 'Price'),
    );
  }

  void _submitAnimalData() {
    _globalKey.currentState.save();
    final Map<String, dynamic> newAnimal = {
      'title': AnimalTitle,
      'desc': description,
      'price': price_,
      'imageUrl': 'asset/cat.jpeg'
    };
    widget.addAnimal(newAnimal);
    Navigator.pushReplacementNamed(context, '/land/');
  }

  @override
  Widget build(BuildContext context) {

    final double mDeviceWidth = MediaQuery.of(context).size.width;
    final double mTargetWidth = mDeviceWidth > 550.0 ? 500 : mDeviceWidth * 0.95;
    final double mPadding = mDeviceWidth - mTargetWidth;

    return Container(

      margin: EdgeInsets.all(10.0),
      child:Form(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: mPadding /2 ),
        children: <Widget>[
          _buildAnimalTitleTextField(),
          _buildAnimalDescriptionTextField(),
          _buildPriceTextField(),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(

            textColor: Colors.white,
            child: Text('Save'),
            onPressed: _submitAnimalData,
          )
        ],
      ),),
    );
  }
}
