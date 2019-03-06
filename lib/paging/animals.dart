/*
 * Copyright (c) 2019. Created by keronei lincoln, \n All rights reserved.
 */

import 'package:flutter/material.dart';
import '../animal_manager.dart';


class AnimalsPage extends StatelessWidget {

  final List<Map<String, dynamic> > animals;


  AnimalsPage(this.animals);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                title: Text("Options"),
                automaticallyImplyLeading: false,
              ),
              ListTile(
                title: Text("Manage Vet"),
                onTap: () {
                 Navigator.pushReplacementNamed(context, '/manager_admin/');
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Vet Lab"),

        ),
        body: AnimalManager(animals),

    );
  }
}
