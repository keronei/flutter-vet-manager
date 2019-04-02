import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './paging/auth.dart';
import './paging/manager.dart';
import './paging/animals.dart';
import './paging/animal.dart';
import './scoped_models/main.dart';
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
  final MainModel _model = MainModel();

  @override
  void initState() {
    _model.autoAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          accentColor: Colors.cyanAccent,
          primarySwatch: Colors.cyan,
          buttonColor: Colors.indigoAccent,
        ),
        //home: AuthPage(),
        routes: {
          '/': (BuildContext context) => ScopedModelDescendant(
                builder: (BuildContext contect, Widget child, MainModel model) {
                  return model.user == null ? AuthPage() : AnimalsPage(_model);
                },
              ),
          '/land/': (BuildContext context) => AnimalsPage(_model),
          '/manager_admin/': (BuildContext context) => ManageAnimalsTop(_model),
        },

        onGenerateRoute: (RouteSettings settings) {
          final List<String> params = settings.name.split('/');

          if (params[0] != '') {
            return null;
          }
          if (params[1] == "animal") {
            final String animalID = params[2];
            //int position = int.parse(params[2]);
            final Animal animal = _model.allAnimals.firstWhere((Animal animal) {
              return animal.auto_id == animalID;
            });
            return MaterialPageRoute<String>(
                builder: (BuildContext context) => AnimalPage(animal));
          }
          return null;
        },
        onUnknownRoute: (RouteSettings params) {
          return MaterialPageRoute(
            builder: (BuildContext context) => AnimalsPage(_model),
          );
        },
      ),
    );
  }
}
