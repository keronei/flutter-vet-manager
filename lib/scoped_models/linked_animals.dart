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

  String urlPointer =
      "http://localhost"; //localhost for iOS or http://10.0.2.2 for android

  Future<Null> fetchDataFromServer() {
    _isLoading = true;
    notifyListeners();
    return my_api
        .get(urlPointer + ':5000/api/v1/vet/')
        .then<Null>((my_api.Response response) {
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
      //_selectedAnimalID = null;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return null;
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

  int get getMeTheIndex {
    return _animals.indexWhere((Animal animal) {
      return animal.auto_id == _selectedAnimalID;
    });
  }

  Animal get selectedAnimal {
    if (_selectedAnimalID == null) {
      return null;
    }
    return _animals.firstWhere((Animal animal) {
      return animal.auto_id == _selectedAnimalID;
    });
  }

  Future<bool> addAnAnimal(
      String title, String desc, String imageUrl, double price) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> animalData = {
      'title': title,
      'desc': desc,
      'imageurl': urlPointer + '/images/ruth.png',
      'price': price,
      'user_mail': _authenticatedUser.mEmail,
      'user_id': _authenticatedUser.mId
    };
    try {
      my_api.Response response = await my_api.post(
          urlPointer + ':5000/api/v1/vet/',
          body: json.encode(animalData),
          headers: {'content-type': 'application/json'});

      if (response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> returnedResponse = json.decode(response.body);

      Animal newAnimal = Animal(
          auto_id: returnedResponse['id'].toString(),
          title: title,
          desc: desc,
          price: price,
          imageUrl: urlPointer + '/images/ruth.png',
          mIsCreatedByMail: _authenticatedUser.mEmail,
          mUserId: _authenticatedUser.mId);
      _animals.add(newAnimal);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (Error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateAnimal(
      String title, String desc, String imageUrl, double price) {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> updatedInfo = {
      'title': title,
      'desc': desc,
      'imageurl': imageUrl,
      'price': price
    };

    var url = urlPointer + ':5000/api/v1/vet/${selectedAnimal.auto_id}';

    return my_api.put(url, body: json.encode(updatedInfo), headers: {
      'content-type': 'application/json'
    }).then((my_api.Response response) {


      if (response.statusCode != 200) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

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
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> deleteAnimal() {
    var deletedID = selectedAnimal.auto_id;

    _animals.removeAt(getMeTheIndex);

    selectAnimalID(null);

    notifyListeners();
    _isLoading = true;
    var url = urlPointer + ':5000/api/v1/vet/${deletedID}';

    return my_api.delete(url).then((my_api.Response response) {
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  void selectAnimalID(String actualId) {
    _selectedAnimalID = actualId;

    if (actualId != null) {
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

  Future<dynamic> signUp(String email, String password) async {
    Map<String, dynamic> authData = {
      'user_name': 'op',
      'phone_number': '0745152310',
      'email': email,
      'password': password,
    };

    final my_api.Response resultAuth = await my_api.post(
        urlPointer + ":5000/api/v1/auth/sign-up/",
        body: json.encode(authData),
        headers: {'content-type': 'application/json'});


    return resultAuth.statusCode;
  }
}

mixin UtilitiesModel on LinkedAnimalsModel {
  bool get isLoading {
    return _isLoading;
  }
}
