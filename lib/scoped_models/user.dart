/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:scoped_model/scoped_model.dart';
import '../models/user.dart';

mixin UserModel on Model {
  User _authenticatedUser;

  void login(String email, String password){
    _authenticatedUser = User(mId: 'jkjkjk', mEmail: email, mUserPassword: password);
  }
}
