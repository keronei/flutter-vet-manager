/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:flutter/material.dart';
class PriceTag extends StatelessWidget{
  final String actual_price;

  const PriceTag(this.actual_price);
  @override
  Widget build(BuildContext context) {
    return                   Container(
      padding:
      EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        'Ksh. ' + actual_price,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}