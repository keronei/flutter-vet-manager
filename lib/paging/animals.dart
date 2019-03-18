/*
 * Copyright (c) 2019. Created by keronei lincoln, \n All rights reserved.
 */

import 'package:flutter/material.dart';
import '../widgets/animals.dart';
import '../models/animal.dart';

class AnimalsPage extends StatelessWidget {

  final List<Animal > animals;


  AnimalsPage(this.animals);

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
            IconButton(icon: Icon(Icons.favorite), color: Colors.white, onPressed: (){

            },)
          ],

        ),
        body: Animals(animals),

    );
  }
}
