/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:flutter/material.dart';

class editAnimal extends StatefulWidget {
  final Function addAnimal;
  final Function updateAnimal;
  final int animalIndex;

  final Map<String, dynamic> singleAnimal;

  editAnimal({this.addAnimal, this.updateAnimal, this.singleAnimal, this.animalIndex});

  @override
  State<StatefulWidget> createState() {
    return _editAnimalState();
  }
}

class _editAnimalState extends State<editAnimal> {
  final Map<String, dynamic> animalAddForm = {
    'title': null,
    'desc': null,
    'price': null,
    'imageUrl': 'asset/cat.jpeg'
  };

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  Widget _buildAnimalTitleTextField() {
    return TextFormField(
        initialValue:
            widget.singleAnimal == null ? '' : widget.singleAnimal['title'],
        validator: (String titleProvided) {
          if (titleProvided.isEmpty || titleProvided.length < 5) {
            return 'Title is reuired, 5 characters min';
          }
        },
        onSaved: (String value) {
          animalAddForm['title'] = value;
        },
        decoration: InputDecoration(
          labelText: "Title",
        ));
  }

  Widget _buildAnimalDescriptionTextField() {
    return TextFormField(
      initialValue:
          widget.singleAnimal == null ? '' : widget.singleAnimal['desc'],
      validator: (String animalName) {
        if (animalName.isEmpty || animalName.length < 6) {
          return 'Description required, 6 characters min';
        }
      },
      onSaved: (String name) {
        animalAddForm['desc'] = name;
      },
      decoration: InputDecoration(labelText: 'Description'),
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      initialValue:
          widget.singleAnimal == null ? '' : widget.singleAnimal['price'].toString(),
      validator: (String inputPrice) {
        if (inputPrice.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(inputPrice)) {
          return ' Price should be a number';
        }
      },
      keyboardType: TextInputType.number,
      onSaved: (String price) {
        animalAddForm['price'] = double.parse(price);
      },
      decoration: InputDecoration(labelText: 'Price'),
    );
  }

  void _submitAnimalData() {
    if (!_globalKey.currentState.validate()) {
      return;
    }
    _globalKey.currentState.save();

    if(widget.singleAnimal == null){

    widget.addAnimal(animalAddForm);
    Navigator.pushReplacementNamed(context, '/land/');}
    else{
      widget.updateAnimal(widget.animalIndex, animalAddForm);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double mDeviceWidth = MediaQuery.of(context).size.width;
    final double mTargetWidth =
        mDeviceWidth > 550.0 ? 500 : mDeviceWidth * 0.95;
    final double mPadding = mDeviceWidth - mTargetWidth;

    Widget pageStructure = GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _globalKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: mPadding / 2),
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
                onPressed: _submitAnimalData ,
              )
            ],
          ),
        ),
      ),
    );

    return widget.singleAnimal == null
        ? pageStructure
        : Scaffold(
            appBar: AppBar(
              title: Text('Update animal'),
            ),
            body: pageStructure,
          );
  }
}
