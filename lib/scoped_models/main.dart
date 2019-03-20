/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:scoped_model/scoped_model.dart';
import './animals.dart';
import './user.dart';
import './linked_animals.dart';

class MainModel extends Model with LinkedAnimals,AnimalsModel, UserModel {}