import 'package:flutter/material.dart';

import './paging/auth.dart';
import './paging/manager.dart';
import './paging/animals.dart';
import './paging/animal.dart';

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
  final List<Map<String, String>> _animals = [];

  void _addAnAnimal(Map<String, String> animal) {
    setState(() {
      _animals.add(animal);
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
      ),
      //home: Auth(),
      routes: {
        '/': (BuildContext context) =>
            AnimalsPage(_animals, _addAnAnimal, _deleteAnimal),
        '/manager_admin/': (BuildContext context) => ManageAnimalsTop(),
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
                  _animals[position]['title'], _animals[position]['imageUrl']));
        }
        return null;
      },
      onUnknownRoute: (RouteSettings params){
        return MaterialPageRoute(builder: (BuildContext context)=>
            AnimalsPage(_animals, _addAnAnimal, _deleteAnimal),
        );
      },
    );
  }
}
