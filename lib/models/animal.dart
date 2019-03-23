/*
 * Copyright (c) 2019. Created by keronei lincoln, All rights reserved.
 */
import 'package:flutter/material.dart';

class Animal {
  final String auto_id;
  final String title;
  final String desc;
  final double price;
  final String imageUrl;
  final bool isFavourite;
  final String mIsCreatedByMail;
  final String mUserId;

  Animal(
      {@required this.auto_id,
      @required this.title,
      @required this.desc,
      @required this.price,
      @required this.imageUrl,
      @required this.mIsCreatedByMail,
      @required this.mUserId,
      this.isFavourite = false});
}
