/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:flutter/material.dart';
import 'animals.dart';
import 'animal_add.dart';
import 'animal_list.dart';

class ManageAnimalsTop extends StatelessWidget{
  final Function addAnimal;
  final Function removeAnimal;

  const ManageAnimalsTop( this.addAnimal, this.removeAnimal) ;

  Widget _buildDawer(BuildContext context){
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(title: Text("Options"),automaticallyImplyLeading: false,),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("All animals"),onTap: (){
            Navigator.pushReplacementNamed(context, '/land/');
          },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 2,
        child: Scaffold(
      drawer:_buildDawer(context) ,
      appBar: AppBar(
        title: Text("Vet Lab"),
        bottom: TabBar(tabs: [
          Tab(
            icon: Icon(Icons.create),
            text: 'Add new',
          ),
          Tab(
            icon: Icon(Icons.format_list_bulleted),
            text: 'Available',
          )
        ]),
      ),
      body: TabBarView(children: [
        AddNewAnimal(addAnimal),
        AnimalList(),

      ]),
    ),);

  }

}