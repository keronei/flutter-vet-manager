import 'package:flutter/material.dart';

import './paging/auth.dart';
import './paging/manager.dart';
import './paging/animals.dart';
import './paging/animal.dart';
import './models/animal.dart';
void main() {
//debugPaintSizeEnabled = true;
//debugPaintBaselinesEnabled = true;

  runApp(CoolApp());
}

class CoolApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CoolAppState();
  }
}

class _CoolAppState extends State<CoolApp> {
  final List<Animal> _animals = [];

  void _addAnAnimal(Animal animal) {
    setState(() {
      _animals.add(animal);
    });
  }

  void _updateAnimal(int index, Animal animalData){
    setState(() {
      _animals[index] = animalData;

    });
  }

  void _deleteAnimal(int position) {
    setState(() {
      _animals.removeAt(position);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.cyanAccent,
        primarySwatch: Colors.cyan,
        buttonColor: Colors.indigoAccent,

      ),
      //home: AuthPage(),
      routes: {
        '/' : (BuildContext context) => AuthPage(),
        '/land/': (BuildContext context) =>
            AnimalsPage(_animals),
        '/manager_admin/': (BuildContext context) =>
            ManageAnimalsTop(_addAnAnimal, _updateAnimal, _deleteAnimal, _animals),
      },

      onGenerateRoute: (RouteSettings settings) {

        final List<String> params = settings.name.split('/');

        if (params[0] != '') {
          return null;
        }
        if (params[1] == "animal") {
          int position = int.parse(params[2]);
          return MaterialPageRoute<String>(
              builder: (BuildContext context) => AnimalPage(
                  _animals[position].title,
                  _animals[position].imageUrl,
                  _animals[position].price,
              _animals[position].desc));
        }
        return null;
      },
      onUnknownRoute: (RouteSettings params){
        return MaterialPageRoute(builder: (BuildContext context)=>
            AnimalsPage(_animals),
        );
      },
    );
  }
}
