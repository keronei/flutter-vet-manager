/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */
import 'package:scoped_model/scoped_model.dart';
import '../models/animal.dart';

class AnimalsModel extends Model {
  int _selectedAnimalIndex;
  final List<Animal> _animals = [];
  bool _isDisplayingFavourite = false;

  bool get displayStatus{
    return _isDisplayingFavourite;
  }

  List<Animal> get animals {
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

  void addAnAnimal(Animal animal) {
    _animals.add(animal);
    _selectedAnimalIndex = null;
    notifyListeners();
  }

  void updateAnimal(Animal animalData) {
    _animals[_selectedAnimalIndex] = animalData;
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
  }
  void toggleDisplay(){

    _isDisplayingFavourite = !_isDisplayingFavourite;
    notifyListeners();
}
}
