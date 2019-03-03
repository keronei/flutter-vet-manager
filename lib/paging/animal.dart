/*
 * Copyright (c) 2019. Created by keronei lincoln, \n All rights reserved.
 */
import 'dart:async';
import 'package:flutter/material.dart';

class AnimalPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  AnimalPage(this.title, this.imageUrl);

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
            Container(padding: EdgeInsets.all(9.0), child: Text(title)),
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
