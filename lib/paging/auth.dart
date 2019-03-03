/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:flutter/material.dart';
import 'animals.dart';

class Auth extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: Center(
        child: RaisedButton(child:Text('login...'),onPressed: (){
          Navigator.pushReplacementNamed(context, '/');
        }),
      ) ,
    );;
  }

}