import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './paging/auth.dart';
import './paging/manager.dart';
import './paging/animals.dart';
import './paging/animal.dart';
import './scoped_models/main.dart';
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



  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: MainModel(),
      child:MaterialApp(
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
            AnimalsPage(),
        '/manager_admin/': (BuildContext context) =>
            ManageAnimalsTop(),
      },

      onGenerateRoute: (RouteSettings settings) {

        final List<String> params = settings.name.split('/');

        if (params[0] != '') {
          return null;
        }
        if (params[1] == "animal") {
          int position = int.parse(params[2]);
          return MaterialPageRoute<String>(
              builder: (BuildContext context) => AnimalPage(position));
        }
        return null;
      },
      onUnknownRoute: (RouteSettings params){
        return MaterialPageRoute(builder: (BuildContext context)=>
            AnimalsPage(),
        );
      },
    ) ,);
  }
}
