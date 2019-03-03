/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:flutter/material.dart';
class AddNewAnimal  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(child: RaisedButton( child: Text("Select"),onPressed: (){
      showModalBottomSheet(context: context, builder: (BuildContext context){
        return Center(
          child: Text("Choose where to add from"),
        );
      });
    }),);
  }
}