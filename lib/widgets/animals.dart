/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:flutter/material.dart';
import '../paging/animal.dart';
import './widgets/price_tag.dart';

class Animals extends StatelessWidget {
  final List<Map<String, dynamic>> animals;

  Animals(this.animals) {}

  Widget _buildAnimalsList(BuildContext context, int position) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(animals[position]['imageUrl']),
          Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    animals[position]['title'],
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Oswald'),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  PriceTag(animals[position]["price"].toString())
                ],
              )),
          DecoratedBox(

            decoration: BoxDecoration(
                border: Border.all(color: Colors.brown, width: 1.5),
                borderRadius: BorderRadius.circular(5.0)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              child: Text('Trans-Zoia county, KE'),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                color: Theme.of(context).accentColor,
               icon: Icon(Icons.details),
                onPressed: () {
                  Navigator.pushNamed<String>(
                      context, '/animal/' + position.toString());
                },
              ),
              IconButton(icon: Icon(Icons.favorite_border),
                  color:Colors.red,onPressed: (){


              }),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildWidgetConditionally() {
    return animals.length > 0
        ? ListView.builder(
            itemBuilder: _buildAnimalsList,
            itemCount: animals.length,
          )
        : Center(
            child: Text("Looks like there is no animal yet, just add"),
          );
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgetConditionally();
  }
}
