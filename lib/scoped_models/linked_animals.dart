/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:scoped_model/scoped_model.dart';
import '../models/user.dart';
import '../models/animal.dart';

mixin LinkedAnimalsModel on Model {
  final List<Animal> _animals = [];
  User _authenticatedUser;
  int _selectedAnimalIndex;

  void addAnAnimal(String title, String desc, String imageUrl, double price) {
    Animal newAnimal = Animal(
        title: title,
        desc: desc,
        price: price,
        imageUrl: imageUrl,
        mIsCreatedByMail: _authenticatedUser.mEmail,
        mUserId: _authenticatedUser.mId);
    _animals.add(newAnimal);
    _selectedAnimalIndex = null;
    notifyListeners();
  }
}
mixin AnimalsModel on LinkedAnimalsModel {


bool _isDisplayingFavourite = false;

bool get displayStatus{
  return _isDisplayingFavourite;
}

List<Animal> get allAnimals {
  return List.from(_animals);
}

List<Animal> get displayAnimals {
  if(_isDisplayingFavourite){
    return _animals.where((Animal animal)=>animal.isFavourite).toList();
  }
  return List.from(_animals);

}

void togleFavouriteStatus() {
  final bool currentStatus = selectedAnimal().isFavourite;
  final updatedStatus = !currentStatus;

  final Animal updatedAnimalStatus = Animal(
      title: selectedAnimal().title,
      desc: selectedAnimal().desc,
      price: selectedAnimal().price,
      imageUrl: selectedAnimal().imageUrl,
      mIsCreatedByMail: selectedAnimal().mIsCreatedByMail,
      mUserId: selectedAnimal().mUserId,
      isFavourite: updatedStatus
  );

  _animals[_selectedAnimalIndex] = updatedAnimalStatus;
  _selectedAnimalIndex = null;
  notifyListeners();
}

int get selectedIndex {
  return _selectedAnimalIndex;
}

Animal selectedAnimal() {
  if (_selectedAnimalIndex == null) {
    return null;
  }
  return _animals[_selectedAnimalIndex];
}


void updateAnimal(String title, String desc, String imageUrl, double price) {

  Animal updatedAnimal = Animal(
      title: title,
      desc: desc,
      price: price,
      imageUrl: imageUrl,
      mIsCreatedByMail: _authenticatedUser.mEmail,
      mUserId: _authenticatedUser.mId);

  _animals[_selectedAnimalIndex] = updatedAnimal;
  _selectedAnimalIndex = null;
  notifyListeners();
}

void deleteAnimal() {
  _animals.removeAt(_selectedAnimalIndex);
  _selectedAnimalIndex = null;
  notifyListeners();
}

void selectAnimalIndex(int index) {
  _selectedAnimalIndex = index;

  if(index != null){
    notifyListeners();
  }

}
void toggleDisplay(){

  _isDisplayingFavourite = !_isDisplayingFavourite;
  notifyListeners();
}
}
mixin UserModel on LinkedAnimalsModel {


void login(String email, String password){
  _authenticatedUser = User(mId: 'jkjkjk', mEmail: email, mUserPassword: password);
}
}
