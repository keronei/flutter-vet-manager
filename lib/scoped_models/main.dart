/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:scoped_model/scoped_model.dart';
import './linked_animals.dart';



class MainModel extends Model with LinkedAnimalsModel,AnimalsModel, UserModel {}