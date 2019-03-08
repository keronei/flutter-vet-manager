/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:flutter/material.dart';

class AddressTag extends StatelessWidget{

  final String address;

  AddressTag(this.address);

  @override
  Widget build(BuildContext context) {
    return  DecoratedBox(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.brown, width: 1.5),
          borderRadius: BorderRadius.circular(5.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Text(address),
      ),
    );
  }

}