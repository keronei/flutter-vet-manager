/*
 * Copyright (c) 2019. Created by keronei lincoln, \n All rights reserved.
 */

import 'package:flutter/material.dart';
import '../widgets/animals.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';


class AnimalsPage extends StatefulWidget {

  final MainModel model;
  AnimalsPage(this.model);
  @override
  State<StatefulWidget> createState() {
    return _AnimalsPage();
  }

}

Widget _buildAnimalsList(){
  return ScopedModelDescendant<MainModel> (builder: (BuildContext context, Widget child, MainModel model){
    Widget Content = Center(child: Text('No entries yet'),);
    if(model.displayAnimals.length > 0 && !model.isLoading){
      Content = Animals();
    }else if(model.isLoading){
      Content = Center( child: CircularProgressIndicator(),);
    }else{

    }
    return Content;



  },);

}

class _AnimalsPage extends State<AnimalsPage>{

  @override
  initState(){
    widget.model.fetchDataFromServer();
    super.initState();

  }

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
            ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){
              return IconButton(icon: Icon(model.displayStatus ? Icons.favorite : Icons.favorite_border ), color: Colors.white, onPressed: (){
                model.toggleDisplay();

              },);
            },) ,
          ],

        ),
        body: _buildAnimalsList()

    );
  }
}
