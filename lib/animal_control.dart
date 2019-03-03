/*
 * Copyright (c) 2019. All rights reserved.
 */

import 'package:flutter/material.dart';

class AnimalController extends StatelessWidget{

  final Function mAddProduct;
  AnimalController(this.mAddProduct);
  @override
  Widget build(BuildContext context) {

    return RaisedButton(
      color: Theme.of(context).primaryColorLight,
      onPressed: () {
            mAddProduct({'title':'Forest cats', 'imageUrl':'asset/cat.jpeg'});
      },
      child: Text("Add Something"),
    );
  }

}