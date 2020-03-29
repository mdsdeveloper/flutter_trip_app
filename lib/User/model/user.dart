import 'package:flutter/material.dart';
import 'package:fluttertripapp/Place/model/place.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String photoUrl;
  final List<Place> myPlaces;
  final List<Place> myFavoritePlaces;
  
  User(
      {Key key,
      @required this.name,
      @required this.email,
      @required this.photoUrl,
      this.myPlaces,
      this.myFavoritePlaces});
}
