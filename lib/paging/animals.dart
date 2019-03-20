/*
 * Copyright (c) 2019. Created by keronei lincoln, \n All rights reserved.
 */

import 'package:flutter/material.dart';
import '../widgets/animals.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/animals.dart';


class AnimalsPage extends StatelessWidget {


  Widget _buildDrawer(BuildContext context){
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Options"),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Manage Vet"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/manager_admin/');
            },
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        drawer: _buildDrawer(context),
        appBar: AppBar(
          title: Text("Vet Lab", style: TextStyle(color: Colors.white),),
          actions: <Widget>[
            ScopedModelDescendant<AnimalsModel>(builder: (BuildContext context, Widget child, AnimalsModel model){
              return IconButton(icon: Icon(model.displayStatus ? Icons.favorite : Icons.favorite_border ), color: Colors.white, onPressed: (){
                model.toggleDisplay();

              },);
            },) ,
          ],

        ),
        body: Animals(),

    );
  }
}
