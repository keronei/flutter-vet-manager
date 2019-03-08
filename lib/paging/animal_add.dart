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

  Widget _buildAnimalTitleTextField() {
    return TextField(
        onChanged: (String value) {
          setState(() {
            AnimalTitle = value;
          });
        },
        decoration: InputDecoration(
          labelText: "Title",
        ));
  }

  Widget _buildAnimalDescriptionTextField() {
    return TextField(
      onChanged: (String name) {
        setState(() {
          description = name;
        });
      },
      decoration: InputDecoration(labelText: 'Description'),
    );
  }

  Widget _buildPriceTextField() {
    return TextField(
      keyboardType: TextInputType.number,
      onChanged: (String price) {
        setState(() {
          price_ = double.parse(price);
        });
      },
      decoration: InputDecoration(labelText: 'Price'),
    );
  }

  void _submitAnimalData() {
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
      ),
    );
  }
}
