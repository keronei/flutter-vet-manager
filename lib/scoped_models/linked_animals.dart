/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */

import 'package:scoped_model/scoped_model.dart';
import '../models/user.dart';
import '../models/animal.dart';
import 'package:http/http.dart' as my_api;
import 'dart:convert';

mixin LinkedAnimalsModel on Model {
  List<Animal> _animals = [];
  User _authenticatedUser;
  String _selectedAnimalID;
  bool _isLoading = false;

  Future<Null> addAnAnimal(
      String title, String desc, String imageUrl, double price) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> animalData = {
      'title': title,
      'desc': desc,
      'imageurl': 'http://10.0.2.2/images/ruth.png',
      'price': price,
      'user_mail': _authenticatedUser.mEmail,
      'user_id': _authenticatedUser.mId
    };

    return my_api.post('http://10.0.2.2:5000/api/v1/vet/',
        body: json.encode(animalData),
        headers: {
          'content-type': 'application/json'
        }).then((my_api.Response response) {
      final Map<String, dynamic> returnedResponse = json.decode(response.body);

      Animal newAnimal = Animal(
          auto_id: returnedResponse['id'].toString(),
          title: title,
          desc: desc,
          price: price,
          imageUrl: 'http://10.0.2.2/images/ruth.png',
          mIsCreatedByMail: _authenticatedUser.mEmail,
          mUserId: _authenticatedUser.mId);
      _animals.add(newAnimal);
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<Null> fetchDataFromServer() {
    _isLoading = true;
    notifyListeners();
   return my_api
        .get('http://10.0.2.2:5000/api/v1/vet/')
        .then((my_api.Response response) {
      final Map<String, dynamic> receivedList = json.decode(response.body);

      if (receivedList == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      final List<Animal> fromServer = [];

      receivedList['data'].forEach((dynamic specific) {
        final Animal loaded = Animal(
            auto_id: specific['id'].toString(),
            title: specific['title'],
            desc: specific['description'],
            price: double.parse(specific['price']),
            imageUrl: specific['imageurl'],
            mIsCreatedByMail: specific['user_mail'],
            mUserId: specific['user_id']);
        fromServer.add(loaded);
      });

      _animals = fromServer;
      _isLoading = false;
      notifyListeners();
    });
  }
}

mixin AnimalsModel on LinkedAnimalsModel {
  bool _isDisplayingFavourite = false;

  bool get displayStatus {
    return _isDisplayingFavourite;
  }

  List<Animal> get allAnimals {
    return List.from(_animals);
  }

  List<Animal> get displayAnimals {
    if (_isDisplayingFavourite) {
      return _animals.where((Animal animal) => animal.isFavourite).toList();
    }
    return List.from(_animals);
  }

  void toggleFavouriteStatus() {
    final bool currentStatus = selectedAnimal.isFavourite;
    final updatedStatus = !currentStatus;

    final Animal updatedAnimalStatus = Animal(
      auto_id: selectedAnimal.auto_id,
        title: selectedAnimal.title,
        desc: selectedAnimal.desc,
        price: selectedAnimal.price,
        imageUrl: selectedAnimal.imageUrl,
        mIsCreatedByMail: selectedAnimal.mIsCreatedByMail,
        mUserId: selectedAnimal.mUserId,
        isFavourite: updatedStatus);

    _animals[getMeTheIndex] = updatedAnimalStatus;

    notifyListeners();
    _selectedAnimalID = null;
  }

  String get selectedIndex {
    return _selectedAnimalID;
  }

  int get getMeTheIndex{
    return _animals.indexWhere((Animal animal){
      return animal.auto_id == _selectedAnimalID;
    });
  }

  Animal get selectedAnimal {
    if (_selectedAnimalID == null) {
      return null;
    }
    return _animals.firstWhere((Animal animal){
      return animal.auto_id == _selectedAnimalID;
    });
  }

  Future<Null> updateAnimal(
      String title, String desc, String imageUrl, double price) {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> updatedInfo = {
      'title': title,
      'desc': desc,
      'imageurl': imageUrl,
      'price': price
    };

    var url = 'http://10.0.2.2:5000/api/v1/vet/${selectedAnimal.auto_id}';

    return my_api.put(url, body: json.encode(updatedInfo), headers: {
      'content-type': 'application/json'
    }).then((my_api.Response response) {
      print(json.decode(response.body));

      _isLoading = false;
      Animal updatedAnimal = Animal(
          auto_id: selectedAnimal.auto_id,
          title: title,
          desc: desc,
          price: price,
          imageUrl: imageUrl,
          mIsCreatedByMail: _authenticatedUser.mEmail,
          mUserId: _authenticatedUser.mId);

      _animals[getMeTheIndex] = updatedAnimal;

      notifyListeners();
    });
  }

  void deleteAnimal() {
    var deletedID = selectedAnimal.auto_id;

    _animals.removeAt(getMeTheIndex);

    selectAnimalID(null);

    notifyListeners();
    _isLoading = true;
    var url = 'http://10.0.2.2:5000/api/v1/vet/${deletedID}';

    my_api.delete(url).then((my_api.Response response) {
      _isLoading = false;
      notifyListeners();

      print(json.encode(response.body));
    });
  }

  void selectAnimalID(String actual_id) {
    _selectedAnimalID = actual_id;

    if (actual_id != null) {
      notifyListeners();
    }
  }

  void toggleDisplay() {
    _isDisplayingFavourite = !_isDisplayingFavourite;
    notifyListeners();
  }
}

mixin UserModel on LinkedAnimalsModel {
  void login(String email, String password) {
    _authenticatedUser =
        User(mId: 'jewds', mEmail: email, mUserPassword: password);
  }
}

mixin UtilitiesModel on LinkedAnimalsModel {
  bool get isLoading {
    return _isLoading;
  }
}
