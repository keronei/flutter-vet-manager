/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:flutter/material.dart';
import '../widgets/helpers/ensure-visible.dart';
import '../models/animal.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';

class EditAnimal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditAnimalState();
  }
}

class _EditAnimalState extends State<EditAnimal> {
  final Map<String, dynamic> animalAddForm = {
    'title': null,
    'desc': null,
    'price': null,
    'imageUrl': 'http://10.0.2.2/images/ruth.png',
  };

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();

  final _descFocusNode = FocusNode();

  final _priceFocusNode = FocusNode();

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading ? Center(child: CircularProgressIndicator()) : RaisedButton(
          textColor: Colors.white,
          child: Text('Save'),
          onPressed: () => _submitAnimalData(
              model.addAnAnimal, model.updateAnimal,model.selectAnimalIndex, model.selectedIndex),
        );
      },
    );
  }

  Widget pageStructureContent(BuildContext context, Animal animalSelected) {
    final double mDeviceWidth = MediaQuery.of(context).size.width;
    final double mTargetWidth =
        mDeviceWidth > 550.0 ? 500 : mDeviceWidth * 0.95;
    final double mPadding = mDeviceWidth - mTargetWidth;

    return GestureDetector(
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
             _buildAnimalTitleTextField(animalSelected),
              _buildAnimalDescriptionTextField(animalSelected),
              _buildPriceTextField(animalSelected),
              SizedBox(
                height: 10.0,
              ),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimalTitleTextField(Animal selectedAnimal) {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
          focusNode: _titleFocusNode,
          initialValue: selectedAnimal == null ? '' : selectedAnimal.title,
          validator: (String titleProvided) {
            if (titleProvided.isEmpty || titleProvided.length < 5) {
              return 'Title is required, 5 characters min';
            }
          },
          onSaved: (String value) {
            animalAddForm['title'] = value;
          },
          decoration: InputDecoration(
            labelText: "Title",
          )),
    );
  }

  Widget _buildAnimalDescriptionTextField(Animal selectedAnimal) {
    return EnsureVisibleWhenFocused(
      focusNode: _descFocusNode,
      child: TextFormField(
        focusNode: _descFocusNode,
        initialValue: selectedAnimal == null ? '' : selectedAnimal.desc,
        validator: (String animalName) {
          if (animalName.isEmpty || animalName.length < 6) {
            return 'Description required, 6 characters min';
          }
        },
        onSaved: (String name) {
          animalAddForm['desc'] = name;
        },
        decoration: InputDecoration(labelText: 'Description'),
      ),
    );
  }

  Widget _buildPriceTextField(Animal selectedAnimal) {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        initialValue:
            selectedAnimal == null ? '' : selectedAnimal.price.toString(),
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
      ),
    );
  }

  void _submitAnimalData(Function addAnimal, Function updateAnimal
  ,indicateNotInterestedAnymore,
      [int selectedAnimalIndex]) {
    if (!_globalKey.currentState.validate()) {
      return;
    }
    _globalKey.currentState.save();

    if (selectedAnimalIndex == null) {
      addAnimal(
        animalAddForm['title'],
        animalAddForm['desc'],
        animalAddForm['imageUrl'],
        animalAddForm['price'],
      ).then((_){
          Navigator.pushReplacementNamed(context, '/land/').then((_)=>indicateNotInterestedAnymore(null));
      });
    } else {
      updateAnimal(
        animalAddForm['title'],
        animalAddForm['desc'],
        animalAddForm['imageUrl'],
        animalAddForm['price'],
      ).then((_){
        Navigator.pushReplacementNamed(context, '/land/').then((_)=>indicateNotInterestedAnymore(null));
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
     final Widget pageStructure = pageStructureContent(context, model.selectedAnimal);
      return model.selectedIndex == null
          ? pageStructure
          : Scaffold(
              appBar: AppBar(
                title: Text('Update animal'),
              ),
              body: pageStructure,
            );
    });
  }
}
