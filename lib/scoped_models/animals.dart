/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */
import 'package:scoped_model/scoped_model.dart';
import '../models/animal.dart';
import './linked_animals.dart';

mixin AnimalsModel on LinkedAnimals {


  bool _isDisplayingFavourite = false;

  bool get displayStatus{
    return _isDisplayingFavourite;
  }

  List<Animal> get allAnimals {
    return List.from(animals);
  }

  List<Animal> get displayAnimals {
    if(_isDisplayingFavourite){
      return animals.where((Animal animal)=>animal.isFavourite).toList();
    }
    return List.from(animals);

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

    animals[selectedAnimalIndex] = updatedAnimalStatus;
    selectedAnimalIndex = null;
    notifyListeners();
  }

  int get selectedIndex {
    return selectedAnimalIndex;
  }

  Animal selectedAnimal() {
    if (selectedAnimalIndex == null) {
      return null;
    }
    return animals[selectedAnimalIndex];
  }


  void updateAnimal(String title, String desc, String imageUrl, double price) {

    Animal updatedAnimal = Animal(
        title: title,
        desc: desc,
        price: price,
        imageUrl: imageUrl,
        mIsCreatedByMail: authenticatedUser.mEmail,
        mUserId: authenticatedUser.mId);

    animals[selectedAnimalIndex] = updatedAnimal;
    selectedAnimalIndex = null;
    notifyListeners();
  }

  void deleteAnimal() {
    animals.removeAt(selectedAnimalIndex);
    selectedAnimalIndex = null;
    notifyListeners();
  }

  void selectAnimalIndex(int index) {
    selectedAnimalIndex = index;

    if(index != null){
      notifyListeners();
    }

  }
  void toggleDisplay(){

    _isDisplayingFavourite = !_isDisplayingFavourite;
    notifyListeners();
}
}
