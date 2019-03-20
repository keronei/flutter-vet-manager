/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:scoped_model/scoped_model.dart';
import '../models/user.dart';
import './linked_animals.dart';

mixin UserModel on LinkedAnimals {


  void login(String email, String password){
    authenticatedUser = User(mId: 'jkjkjk', mEmail: email, mUserPassword: password);
  }
}
