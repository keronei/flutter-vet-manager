import 'package:flutter/material.dart';

import './paging/landing.dart';

void main() {
//debugPaintSizeEnabled = true;
//debugPaintBaselinesEnabled = true;

  runApp(CoolApp());
}

class CoolApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.purpleAccent,
        primarySwatch: Colors.deepPurple,
      ),
      home: LandingPage()
    );
  }
}
