/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthState();
  }
}

class _AuthState extends State<AuthPage> {
  final Map<String, dynamic> _formAuthData = {
    'user_mail': null,
    'password': null,
    'tandc': false
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DecorationImage _decorationImageBuilder() {
    return DecorationImage(
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
        image: AssetImage('asset/catlogin.jpg'));
  }

  Widget _userEmailTF() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Email", filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (String email) {
        if (email.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(email)) {
          return 'Please enter a valid email';
        }
      },
      onSaved: (String email) {
        _formAuthData['user_mail'] = email;
      },
    );
  }

  Widget _userPasswordTF() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: "Password", filled: true, fillColor: Colors.white),
      validator: (String pass) {
        if (pass.isEmpty || pass.length < 6) {
          return 'Invalid password';
        }
      },
      onSaved: (String pass) {
        _formAuthData['password'] = pass;
      },
    );
  }

  Widget _buildSwitchTile() {
    return SwitchListTile(
      value: _formAuthData['tandc'],
      onChanged: (bool Value) {
        setState(() {
          _formAuthData['tandc'] = Value;
        });
      },
      title: Text('Agree to T & C'),
    );
  }

  void _submitLogin(Function Login) {
    if (!_formKey.currentState.validate() || !_formAuthData['tandc']) {
      return;
    }
    _formKey.currentState.save();
    Login(_formAuthData['user_mail'], _formAuthData['password']);

    Navigator.pushReplacementNamed(context, '/land');
  }

  @override
  Widget build(BuildContext context) {
    final double mDeviceWidth = MediaQuery.of(context).size.width;
    final double mTargetWidth =
        mDeviceWidth > 768.0 ? 500 : mDeviceWidth * 0.95;

    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: Container(
        decoration: BoxDecoration(image: _decorationImageBuilder()),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: mTargetWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _userEmailTF(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _userPasswordTF(),
                    _buildSwitchTile(),
                    ScopedModelDescendant<MainModel>(
                      builder: (BuildContext, Widget child, MainModel model) {
                        return RaisedButton(
                          child: Text('login'),
                          textColor: Colors.white,
                          onPressed:()=> _submitLogin(model.login),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
