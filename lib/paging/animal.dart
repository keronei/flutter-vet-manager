/*
 * Copyright (c) 2019. Created by keronei lincoln, \n All rights reserved.
 */
import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/ui_elements/title.dart';
import '../widgets/animals/address_tag.dart';
import '../widgets/animals/price_tag.dart';

class AnimalPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;

  AnimalPage(this.title, this.imageUrl, this.price);

  _ShowWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Deletion"),
            content: Text("This action cannot be undone"),
            actions: <Widget>[
              FlatButton(
                child: Text("proceed"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, "remove");
                },
              ),
              FlatButton(
                child: Text("cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  Widget _buildAddressPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Trans-Zoia, Ke',
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            '|',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Text(
          'Ksh. ' + price.toString(),
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, "dont");
        print("Sprint with false");
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imageUrl),
            Container(padding: EdgeInsets.all(9.0), child: TitleDefault(title)),
            _buildAddressPriceRow(),
            Container(
              padding: EdgeInsets.all(9.0),
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('remove'),
                onPressed: () => _ShowWarningDialog(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
