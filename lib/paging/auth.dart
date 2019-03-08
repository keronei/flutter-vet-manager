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



  DecorationImage _decorationImageBuilder(){
   return  DecorationImage(
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3), BlendMode.dstATop),
        image: AssetImage('asset/catlogin.jpg'));
  }

  Widget _userEmailTF(){
    return  TextField(
      decoration: InputDecoration(
          labelText: "Email",
          filled: true, fillColor: Colors.white
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (String musermail) {
        setState(() {
          user_mail = musermail;
        });
      },
    );
  }

  Widget _userPasswordTF(){
    return   TextField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: "Password",
          filled: true, fillColor: Colors.white
      ),
      onChanged: (String muserpass) {
        setState(() {
          user_password = muserpass;
        });
      },
    );
  }
  Widget _buildSwitchTile(){
    return    SwitchListTile(
      value: terms_and_conditions,
      onChanged: (bool Value) {
        setState(() {
          terms_and_conditions = Value;
        });
      },
      title: Text('Agree to T & C'),
    );
  }

  void _submitLogin() {

    Navigator.pushReplacementNamed(context, '/land');
  }

  @override
  Widget build(BuildContext context) {

    final double mDeviceWidth = MediaQuery.of(context).size.width;
    final double mTargetWidth = mDeviceWidth > 768.0 ? 500 : mDeviceWidth * 0.95;


    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: Container(
        decoration: BoxDecoration(
            image:_decorationImageBuilder()),
        padding: EdgeInsets.all(10.0),
       child: Center(

       child: SingleChildScrollView(
        child: Container(
          width:mTargetWidth,
          child: Column(
          children: <Widget>[
           _userEmailTF(),
            SizedBox(height: 10.0,),
          _userPasswordTF()
          ,_buildSwitchTile()
         ,
            RaisedButton(
                child: Text('login'),
                textColor: Colors.white,
                onPressed: _submitLogin,)
          ],
        ),
      ),),
    ),),);
    ;
  }
}
