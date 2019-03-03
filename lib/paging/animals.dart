/*
 * Copyright (c) 2019. Created by keronei lincoln, \n All rights reserved.
 */

import 'package:flutter/material.dart';
import '../animal_manager.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Super List"),
      ),
      body: AnimalManager(),
    );
  }

}