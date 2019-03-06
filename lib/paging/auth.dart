/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:flutter/material.dart';
import 'animals.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthState();
  }
}

class _AuthState extends State<AuthPage> {
  String user_mail;
  String user_password;
  bool terms_and_conditions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: "Email",
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (String musermail) {
                setState(() {
                  user_mail = musermail;
                });

              },
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
              ),
              onChanged: (String muserpass) {
                setState(() {
                  user_password = muserpass;
                });

              },
            ),
            SwitchListTile(
              value: terms_and_conditions,
              onChanged: (bool Value) {
                setState(() {
                  terms_and_conditions = Value;
                });
              },
              title: Text('Agree to T & C'),
            ),
            RaisedButton(
                child: Text('login'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                })
          ],
        ),
      ),
    );
    ;
  }
}
