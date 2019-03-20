/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:flutter/material.dart';
import 'price_tag.dart';
import '../ui_elements/title.dart';
import './address_tag.dart';
import '../../models/animal.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_models/main.dart';

class AnimalCard extends StatelessWidget {
  final Animal animal;

  final int animalIndex;

  const AnimalCard(this.animal, this.animalIndex);

  Widget _buldTitleAndTag() {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TitleDefault(animal.title),
            SizedBox(
              width: 10.0,
            ),
            PriceTag(animal.price.toString())
          ],
        ));
  }

  ButtonBar _builtButtons(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          color: Theme.of(context).accentColor,
          icon: Icon(Icons.details),
          onPressed: () {
            Navigator.pushNamed<String>(
                context, '/animal/' + animalIndex.toString());
          },
        ),
        ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {

            return IconButton(
                icon: model.animals[animalIndex].isFavourite ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                color: Colors.red,
                onPressed: () {
                  model.selectAnimalIndex(animalIndex);
                  model.togleFavouriteStatus();
                });
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(animal.imageUrl),
          _buldTitleAndTag(),
          AddressTag('Trans-Zoia, Ke'),
          _builtButtons(context),
        ],
      ),
    );
    ;
  }
}
