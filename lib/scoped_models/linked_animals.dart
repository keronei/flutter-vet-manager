/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:scoped_model/scoped_model.dart';
import '../models/user.dart';
import '../models/animal.dart';

mixin LinkedAnimals on Model {
  final List<Animal> animals = [];
  User authenticatedUser;
  int selectedAnimalIndex;

  void addAnAnimal(String title, String desc, String imageUrl, double price) {
    Animal newAnimal = Animal(
        title: title,
        desc: desc,
        price: price,
        imageUrl: imageUrl,
        mIsCreatedByMail: authenticatedUser.mEmail,
        mUserId: authenticatedUser.mId);
    animals.add(newAnimal);
    selectedAnimalIndex = null;
    notifyListeners();
  }
}
